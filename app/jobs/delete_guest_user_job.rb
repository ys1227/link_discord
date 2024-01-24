class DeleteGuestUserJob < ApplicationJob
  queue_as :guest

  def perform
    User.where(is_guest:true).past_hour_user_create.destroy_all
  end
end
