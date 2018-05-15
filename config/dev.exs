use Mix.Config

config :logger, level: :warn

config :burox,
  buro_url: System.get_env("BURO_URL"),
  buro_user: System.get_env("BURO_USER"),
  buro_password: System.get_env("BURO_PASSWORD"),
  buro_url_prospector: System.get_env("BURO_URL_PROSPECTOR"),
  buro_user_prospector: System.get_env("BURO_USER_PROSPECTOR"),
  buro_password_prospector: System.get_env("BURO_PROSPECTOR"),
  buro_service: Burox.BuroService.Socket
