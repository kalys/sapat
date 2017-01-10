use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sapat, Sapat.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :sapat, Sapat.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "sapat_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :arc,
  bucket: "sapat-test",
  asset_host: "https://s3.eu-central-1.amazonaws.com/sapat-test"

config :ex_aws,
  access_key_id: ["AKIAJ3J4FGMBETKPFVOA", :instance_role],
  secret_access_key: ["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", :instance_role],
  region: "eu-central-1"

# disable encryption for faster tests
config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1
