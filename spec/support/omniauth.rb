# テスト用にモックを使うための設定
# '/auth/provider'へのリクエストが、即座に'/auth/provider/callback'にリダイレクトされる
OmniAuth.config.test_mode = true

# Discord用のモック
# '/auth/provider/callback'にリダイレクトされた時に渡されるデータを生成
OmniAuth.config.mock_auth[:discord] = OmniAuth::AuthHash.new(
  uid: '12345',
  info: {
    name: 'test',
    email: 'test@example.com',
    image: 'test'
  }
)


