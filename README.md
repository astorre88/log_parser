# LogParser

The library for grep large files using CPU cores simultaneously.

## Usage

```elixir
# Add message:
LogParser.grep_file("/source/path", "search_word") # => {:ok, ["1st string with search_word\n", "2nd string with search_word\n", "3d string with search_word\n"]}
```
