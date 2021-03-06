use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :sapat, Sapat.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../", __DIR__)]]


# Watch static and templates for browser reloading.
config :sapat, Sapat.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :sapat, Sapat.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "sapat_dev",
  pool_size: 10

config :arc,
  storage: Arc.Storage.S3

config :arc,
  bucket: "sapat-dev",
  asset_host: "https://s3.eu-central-1.amazonaws.com/sapat-dev"

config :ex_aws,
  access_key_id: ["AKIAJ3J4FGMBETKPFVOA", :instance_role],
  secret_access_key: ["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", :instance_role],
  region: "eu-central-1"
