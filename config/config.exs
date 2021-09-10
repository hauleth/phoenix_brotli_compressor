import Config

config :phoenix,
  json_library: Jason,
  static_compressors: [PhoenixBrotliCompressor]
