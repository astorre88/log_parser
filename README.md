# LogParser
[![Build Status](https://api.travis-ci.org/astorre88/log_parser.svg?branch=master)](https://travis-ci.org/astorre88/log_parser)
[![Coverage Status](https://coveralls.io/repos/github/astorre88/log_parser/badge.svg?branch=master)](https://coveralls.io/github/astorre88/log_parser?branch=master)

The library for grep large files using CPU cores simultaneously.

## Usage

```elixir
# Grep the file and get list of matches:
LogParser.grep_file("/source/path", "search_word") # => {:ok, ["1st string with search_word\n", "2nd string with search_word\n", "3d string with search_word\n"]}

# Grep whole folder and get list of matches:
LogParser.grep_whole_folder("/source/path", "search_word") # => {:ok, ["1st string with search_word\n", "2nd string with search_word\n", "3d string with search_word\n"]}

# Grep to file:
LogParser.grep_file_to_file("/source/path", "search_word", "/destination/path") # => {:ok, ["1st string with search_word\n", "2nd string with search_word\n", "3d string with search_word\n"]}
```
