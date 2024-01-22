class UserSessionsController < ApplicationController
  skip_before_action :check_logged_in, only: :create

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

  private

  # callbackURLが返ってきたときにauth_hashが返される
  def auth_hash
    request.env['omniauth.auth']
  end
end
