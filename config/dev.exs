use Mix.Config

config :logger, level: :warn

config :burox,
  buro_url: System.get_env("BURO_URL"),
  buro_user: System.get_env("BURO_USER"),
  buro_password: System.get_env("BURO_PASSWORD"),
  buro_service: Burox.BuroService.Socket
