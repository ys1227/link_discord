class MatchingTimesController < ApplicationController
  def index
    @question = Question.find(params[:question_id])
    @matching_time = MatchingTime.find(params[:question_id])
    @votes = @matching_time.reservation.votes
  end
end
