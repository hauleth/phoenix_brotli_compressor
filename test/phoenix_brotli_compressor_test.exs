defmodule PhoenixBrotliCompressorTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  @assets_dir "test/fixtures/"

  describe "library" do
    @tag :tmp_dir
    test "encode files", %{tmp_dir: tmp_dir} do
      run([@assets_dir, "-o", tmp_dir])

      assert "test.txt.br" in File.ls!(tmp_dir)
      assert "test-2482cc4df40800ca35f6b294884c0fe6.txt.br" in File.ls!(tmp_dir)
    end
  end

  describe "executable" do
    setup do
      :code.purge(:brotli)
      :code.delete(:brotli)
      ebin_path = Mix.Project.compile_path(app: :brotli, build_per_environment: true)

      assert Code.delete_path(ebin_path)

      on_exit(fn ->
        Code.prepend_path(ebin_path)
      end)

      :ok
    end

    @tag :tmp_dir
    test "encode files", %{tmp_dir: tmp_dir} do
      run([@assets_dir, "-o", tmp_dir])

      assert "test.txt.br" in File.ls!(tmp_dir)
      assert "test-2482cc4df40800ca35f6b294884c0fe6.txt.br" in File.ls!(tmp_dir)
    end

    @tag :tmp_dir
    test "throws error when utility not available", %{tmp_dir: tmp_dir} do
      Application.put_env(:phoenix_brotli_compressor, :path, nil)

      assert_raise RuntimeError, fn ->
        run([@assets_dir, "-o", tmp_dir])
      end
    after
      Application.delete_env(:phoenix_brotli_compressor, :path)
    end
  end

  defp run(opts) do
    capture_io(fn ->
      Mix.Task.rerun("phx.digest", opts)
    end)
  end
end
