class DeleteGuestUserJob < ApplicationJob
  queue_as :guest

  def perform
    User.where(name:"Guest").past_hour_user_create.destroy_all
  end
end
