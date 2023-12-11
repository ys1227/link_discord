class ApplicationController < ActionController::Base

  include UserSessionsHelper
  before_action :check_logged_in
  add_flash_types :success, :danger

  def check_logged_in
    return if current_user

    redirect_to root_path, danger: 'ログインしてください'
  end
end
