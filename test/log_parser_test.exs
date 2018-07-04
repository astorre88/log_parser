defmodule LogParserTest do
  use ExUnit.Case, async: true
  doctest LogParser

  setup do
    {
      :ok,
      existed_file_path: Path.join([Path.expand("../log_parser/fixtures"), "fixture_log.txt"]),
      nonexisted_file_path: "/grep_res2",
      search_string: "fun"
    }
  end

  test "logs error", context do
    assert LogParser.grep_file(context.nonexisted_file_path, context.search_string) ==
             {:error, "File #{context.nonexisted_file_path} is not exists!"}
  end

  test "collects matched lines", context do
    assert LogParser.grep_file(context.existed_file_path, context.search_string) ==
             {:ok, ["fun\n", "fun\n", "fun\n"]}
  end
end
