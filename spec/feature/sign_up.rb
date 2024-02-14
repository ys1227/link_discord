before do
  # Facebookのモックをomniauth.authに設定
  Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:discord]
end