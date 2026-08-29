#include <fstream>
#include <iostream>
#include <string>
#include <vector>

struct Comment {
  size_t line;      // 1-based line in the current file
  std::string text; // comment text without leading "# "
};

static const std::string MARKER = "#----------------";

static std::string trim(const std::string& s) {
  size_t b = s.find_first_not_of(" \t\r");
  if (b == std::string::npos) return "";
  size_t e = s.find_last_not_of(" \t\r");
  return s.substr(b, e - b + 1);
}

// Find top-level comments, i.e. lines whose first non-space char is '#'
// and which are outside Nix strings ("..." and ''...'').
// Lines inside the auto-generated block (between START and END tags) are
// skipped so idempotent re-runs don't treat the pointers as comments.
static std::vector<Comment> findComments(const std::vector<std::string>& lines,
                                         size_t blockStart, size_t blockEnd) {
  std::vector<Comment> out;
  bool inMulti = false; // inside '' ... ''
  bool inDq = false;    // inside " ... "

  for (size_t i = 0; i < lines.size(); ++i) {
    size_t lineNo = i + 1;
    if (blockStart && lineNo >= blockStart && lineNo <= blockEnd) continue;
    const std::string& raw = lines[i];
    size_t n = raw.size();
    bool lineIsComment = false;

    if (!inMulti && !inDq) {
      size_t k = raw.find_first_not_of(" \t");
      if (k != std::string::npos && raw[k] == '#') {
        // Confirm the whole line stays in top-level state (the line could
        // open and close strings, which we've already walked in previous i).
        lineIsComment = true;
      }
    }

    // Walk the line to update string state for subsequent lines.
    size_t j = (inMulti || inDq) ? 0 : 0;
    for (; j < n; ++j) {
      char c = raw[j];
      if (inDq) {
        if (c == '\\') { ++j; continue; }
        if (c == '"') inDq = false;
        continue;
      }
      if (inMulti) {
        if (c == '\'' && j + 1 < n && raw[j + 1] == '\'') {
          inMulti = false;
          ++j;
          continue;
        }
        continue;
      }
      // top level
      if (c == '"') { inDq = true; continue; }
      if (c == '\'' && j + 1 < n && raw[j + 1] == '\'') {
        inMulti = true;
        ++j;
        continue;
      }
    }

    if (lineIsComment && !inMulti && !inDq) {
      std::string text = trim(raw);
      if (text.size() >= 1 && text[0] == '#') {
        text = text.substr(1);
        if (!text.empty() && text[0] == ' ') text = text.substr(1);
      }
      out.push_back({i + 1, text});
    }
  }
  return out;
}

int main(int argc, char** argv) {
  std::string path = "/etc/nixos/home/full.nix";
  bool dry = false;
  for (int a = 1; a < argc; ++a) {
    std::string arg = argv[a];
    if (arg == "--dry" || arg == "-n") dry = true;
    else if (arg == "--target" && a + 1 < argc) path = argv[++a];
    else path = arg;
  }

  std::ifstream in(path);
  if (!in) { std::cerr << "cannot open: " << path << "\n"; return 1; }
  std::vector<std::string> lines;
  std::string line;
  while (std::getline(in, line)) lines.push_back(line);
  in.close();

  size_t startLine = 0, endLine = 0;
  bool foundStart = false;
  for (size_t i = 0; i < lines.size(); ++i) {
    if (trim(lines[i]) == MARKER) {
      if (!foundStart) { startLine = i + 1; foundStart = true; }
      else { endLine = i + 1; break; }
    }
  }
  size_t oldH = (startLine && endLine) ? (endLine - startLine + 1) : 0;

  auto comments = findComments(lines, startLine, endLine);
  size_t newH = comments.size() + 2; // two marker lines

  std::vector<std::string> newBlock;
  newBlock.push_back(MARKER);
  for (auto& c : comments) {
    size_t finalLine;
    if (startLine == 0) {
      finalLine = c.line + newH; // block prepended at top shifts everything
    } else if (c.line < startLine) {
      finalLine = c.line;
    } else { // c.line > endLine (comments are body lines after block)
      finalLine = c.line - oldH + newH;
    }
    newBlock.push_back("#" + c.text + " - :" + std::to_string(finalLine) + "j");
  }
  newBlock.push_back(MARKER);

  std::vector<std::string> oldBlock;
  if (startLine) for (size_t i = startLine - 1; i < endLine; ++i) oldBlock.push_back(lines[i]);

  // Build the final file content.
  std::vector<std::string> final;
  if (startLine) {
    for (size_t i = 0; i < startLine - 1; ++i) final.push_back(lines[i]);
    for (auto& b : newBlock) final.push_back(b);
    for (size_t i = endLine; i < lines.size(); ++i) final.push_back(lines[i]);
  } else {
    for (auto& b : newBlock) final.push_back(b);
    for (auto& l : lines) final.push_back(l);
  }

  // Print diff.
  std::cout << "Proposed changes to " << path << ":\n";
  size_t printCount = std::max(oldBlock.size(), newBlock.size());
  bool any = false;
  for (size_t i = 0; i < printCount; ++i) {
    std::string a = i < oldBlock.size() ? oldBlock[i] : "";
    std::string b = i < newBlock.size() ? newBlock[i] : "";
    if (a == b) continue;
    any = true;
    if (i < oldBlock.size() && oldBlock[i].size()) std::cout << "- " << a << "\n";
    if (i < newBlock.size()) std::cout << "+ " << b << "\n";
  }
  if (!any) {
    std::cout << "(no changes)\n";
    return 0;
  }

  if (dry) { std::cout << "(dry run, nothing written)\n"; return 0; }

  std::cout << "Write these changes? [y/N] ";
  std::string resp;
  std::getline(std::cin, resp);
  if (resp != "y" && resp != "Y" && resp != "yes") {
    std::cout << "aborted\n";
    return 0;
  }

  std::ofstream out(path);
  if (!out) { std::cerr << "cannot write: " << path << "\n"; return 1; }
  for (auto& l : final) out << l << "\n";
  out.close();
  std::cout << "written\n";
  return 0;
}
