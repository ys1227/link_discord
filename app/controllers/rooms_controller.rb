class RoomsController < ApplicationController
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
