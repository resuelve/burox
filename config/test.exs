use Mix.Config

config :logger, level: :warn

config :burox,
  buro_user: "user",
  buro_password: "password",
  buro_service: Burox.BuroService.Mock
