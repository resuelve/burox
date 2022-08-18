use Mix.Config

config :logger, level: :warn

config :burox,
  buro_user: "user",
  buro_password: "password",
  buro_user_sae: "user_sae",
  buro_password_sae: "password_sae",
  buro_user_special: "user_special",
  buro_password_special: "password_special",
  buro_user_special_sae: "user_special_sae",
  buro_password_special_sae: "password_special_sae",
  buro_user_propsector: "user",
  buro_password_prospector: "password",
  buro_service: Burox.BuroService.Mock
