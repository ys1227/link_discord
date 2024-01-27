class MessageBroadcastJob < ApplicationJob
  queue_as :broadcast

  def perform(message)
    ActionCable.server.broadcast(
      "chat_#{message.question_id}", 
      { 
        sent_by: message.user.name,
        body: render_message(message) 
      }
      )
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
