class RoomsController < ApplicationController
  # before_action :check_guest_login, only: %i[show]
  def show
    @question = Question.find(params[:id])
    @messages = @question.messages.all
  end

  def destroy
    @question = Question.find(params[:question_id])
    @message = Message.find(params[:id])
    @message.destroy!

    redirect_to room_path(@question), status: :see_other
  end
end
