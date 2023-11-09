class UserSessionsController < ApplicationController
  skip_before_action :check_logged_in, only: :create
  
  def create
    if (user = User.find_or_create_from_auth_hash(auth_hash))
      log_in user
    end
    redirect_to root_path
  end
   
  def destroy
    log_out
    redirect_to root_path, status: :see_other, danger: 'ログアウトしました'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end