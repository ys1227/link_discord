class Message < ApplicationRecord
  belongs_to :user
  belongs_to :question

  after_create_commit { MessageBroadcastJob.perform_later self }
end
