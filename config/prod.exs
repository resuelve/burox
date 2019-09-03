use Mix.Config

config :logger, level: :warn

config :burox,
  buro_url: [{:system, "BURO_URL"}, :instance_role],
  buro_user: [{:system, "BURO_USER"}, :instance_role],
  buro_password: [{:system, "BURO_PASSWORD"}, :instance_role],
  buro_user_special: [{:system, "BURO_USER_SPECIAL"}, :instance_role],
  buro_password_special: [{:system, "BURO_PASSWORD_SPECIAL"}, :instance_role],
  buro_url_prospector: [{:system, "BURO_URL_PROSPECTOR"}, :instance_role],
  buro_user_prospector: [{:system, "BURO_USER_PROSPECTOR"}, :instance_role],
  buro_password_prospector: [{:system, "BURO_PASSWORD_PROSPECTOR"}, :instance_role],
  buro_service: Burox.BuroService.Socket
