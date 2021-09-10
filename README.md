# PhoenixBrotliCompressor

Brotli compressor for Phoenix assets.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `phoenix_brotli_compressor` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phoenix_brotli_compressor, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/phoenix_brotli_compressor](https://hexdocs.pm/phoenix_brotli_compressor).

In addition to the the above you will need either add:

```elixir
def deps do
  [
    {:brotli, github: "hauleth/erl-brotli"}
  ]
end
```

Or install `brotli` CLI utility. You configure compressor to use fixed path via
application configuration:

```elixir
config :phoenix_brotli_compressor, :path, path_to_brotli_cli
```
