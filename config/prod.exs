use Mix.Config

config :logger, level: :warn

config :burox,
  buro_url: [{:system, "BURO_URL"}, :instance_role],
  buro_user: [{:system, "BURO_USER"}, :instance_role],
  buro_password: [{:system, "BURO_PASSWORD"}, :instance_role],
  buro_service: Burox.BuroService.Socket
