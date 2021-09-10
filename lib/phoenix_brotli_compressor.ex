defmodule PhoenixBrotliCompressor do
  @behaviour Phoenix.Digester.Compressor

  require Logger

  @impl true
  def file_extensions, do: ~w[.br]

  @impl true
  def compress_file(file_path, content) do
    if Path.extname(file_path) in Application.fetch_env!(:phoenix, :gzippable_exts) do
      compress(content)
    else
      :error
    end
  end

  defp compress(content) do
    case encode(content) do
      {:ok, compressed} when byte_size(compressed) < byte_size(content) ->
        {:ok, compressed}

      _ ->
        :error
    end
  end

  defp encode(content) do
    cond do
      Code.ensure_loaded?(:brotli) and function_exported?(:brotli, :encode, 1) ->
        :brotli.encode(content)

      path = find_executable() ->
        executable(path, content)

      true ->
        raise "No `brotli` utility"
    end
  end

  defp find_executable do
    case Application.fetch_env(:phoenix_brotli_compressor, :path) do
      {:ok, path} -> path
      _ -> System.find_executable("brotli")
    end
  end

  defp executable(path, content) do
    dir = Path.join([System.tmp_dir!(), "phoenix_brotli"])
    hash = Base.url_encode64(:erlang.md5(content), padding: false)
    File.mkdir_p!(dir)
    file = Path.join(dir, hash)
    File.write!(file, content)

    try do
      case System.cmd(path, ["-c", "--", file], env: []) do
        {output, 0} ->
          {:ok, output}

        _ ->
          :error
      end
    after
      File.rm(file)
    end
  end
end
