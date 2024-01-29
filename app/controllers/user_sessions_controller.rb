class UserSessionsController < ApplicationController
  skip_before_action :check_logged_in, only: %i[create guest_login]

  def create
    if (user = User.find_or_create_from_auth_hash(auth_hash))
      log_in user
      redirect_to root_path, success: 'ログインに成功しました'
    else
      redirect_to root_path, danger: 'ログインに失敗しました。RUNTEQサーバーに参加していないとログインできないので参加しているか確認してみてね！'
    end
  end

  def destroy
    log_out
    redirect_to root_path, status: :see_other, danger: 'ログアウトしました'
  end

  def guest_login
    @guest_user = User.create(
      name: 'Guest',
      email: SecureRandom.alphanumeric(10) + "@email.com",
      crypted_password: 'password',
      salt: 'password',
      image: '1_test.png',
      is_guest: true
    )
    auto_login(@guest_user)
    redirect_to root_path, success: 'ゲストとしてログインしました'
  end

  private

  # callbackURLが返ってきたときにauth_hashが返される
  def auth_hash
    request.env['omniauth.auth']
  end
end
