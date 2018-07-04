defmodule LogParser do
  @moduledoc """
  `LogParser` is the main module of multithreading grep lib.
  """

  @doc """
  Grep file and returns list of matches.
  """
  @spec grep_file(path :: String.t(), finded_str :: String.t()) ::
          {{:ok, List} | {:error, String.t()}}
  def grep_file(path, finded_str) when is_binary(path) and is_binary(finded_str) do
    case File.exists?(path) do
      true ->
        finded_regexp = Regex.compile!(finded_str)

        result =
          path
          |> File.stream!()
          |> grep_stream(finded_regexp)

        {:ok, result}

      _ ->
        {:error, "File #{path} is not exists!"}
    end
  end

  @doc """
  Grep file and writes list of matches to another file.
  """
  @spec grep_file_to_file(
          source_path :: String.t(),
          finded_str :: String.t(),
          destination_path :: String.t()
        ) :: {{:ok, String.t()} | {:error, String.t()}}
  def grep_file_to_file(source_path, finded_str, destination_path)
      when is_binary(source_path) and is_binary(finded_str) and is_binary(destination_path) do
    case grep_file(source_path, finded_str) do
      {:ok, result_list} ->
        write_list_to_file(result_list, destination_path)

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Grep every file in folder and returns list of matches.
  """
  @spec grep_whole_folder(path :: String.t(), finded_str :: String.t()) ::
          {{:ok, List} | {:error, String.t()}}
  def grep_whole_folder(path, finded_str) when is_binary(path) and is_binary(finded_str) do
    case File.exists?(path) do
      true ->
        finded_regexp = Regex.compile!(finded_str)

        streams =
          for file <- File.ls!(path) do
            File.stream!("#{path}/#{file}", read_ahead: 100_000)
          end

        result = grep_stream_list(streams, finded_regexp)
        {:ok, result}

      _ ->
        {:error, "Folder #{path} is not exists!"}
    end
  end

  defp grep_stream(%File.Stream{} = stream, finded_regexp) do
    stream
    |> Flow.from_enumerable()
    |> flow_filter(finded_regexp)
  end

  defp grep_stream_list(stream_list, finded_regexp) when is_list(stream_list) do
    stream_list
    |> Flow.from_enumerables()
    |> flow_filter(finded_regexp)
  end

  defp flow_filter(flow, finded_regexp) do
    flow
    |> Flow.filter(&Regex.match?(finded_regexp, &1))
    |> Enum.to_list()
  end

  defp write_list_to_file(list, destination_path) do
    res =
      list
      |> Enum.join()
      |> File.write(destination_path)

    case res do
      {:error, reason} -> {:error, reason}
      _ -> destination_path
    end
  end
end
