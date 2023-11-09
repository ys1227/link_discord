class RoomsController < ApplicationController
  skip_before_action :check_logged_in,only: %i[show]
  def show
    @question = Question.find(params[:id])
    @messages = @question.messages.all
  end
end
