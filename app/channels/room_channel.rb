class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:question_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # identifierからquestion_idを取得
    identifier = JSON.parse(self.identifier)
    question_id = identifier['question_id']

    # dataが文字列ではなくハッシュとして渡されている場合の対応
    # JSON.parseは不要なので削除して、直接dataを使用する
    question = Question.find(question_id)
    message = question.messages.new(content: data['message'])
    message.user = current_user
    message.save!

    perform(message)
  end

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
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: })
  end
end
