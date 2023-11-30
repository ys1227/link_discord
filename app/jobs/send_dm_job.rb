class SendDmJob < ApplicationJob
  queue_as :default

  def perform(*args)
    p "Hello Active Job."
  end
end
