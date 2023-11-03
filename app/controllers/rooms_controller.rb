class RoomsController < ApplicationController
  skip_before_action :require_login,only: %i[show]
  def show
    @question = Question.find(params[:id])
    @messages = @question.messages.all
  end
end
