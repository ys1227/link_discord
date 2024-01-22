Rails.application.config.middleware.use OmniAuth::Builder do
  provider :discord, ENV['DISCORD_CLIENT_ID'], ENV['DISCORD_CLIENT_SECRET'], scope: 'email identify'

  on_failure do |env|
    error_type = env['omniauth.error.type']
    error_message = env['omniauth.error']

    # リダイレクト先を設定
    # 例: rootにリダイレクト
    env['omniauth.origin'] = '/'

    Rack::Response.new(['302 Moved'], 302, 'Location' => env['omniauth.origin']).finish
  end
end
