class MatchingTimesController < ApplicationController
  def index
    @question = Question.find(params[:question_id])
    @matching_time = MatchingTime.find_by(question_id: params[:question_id])
    if @matching_time != nil
      @votes = @matching_time.reservation.votes
    end
  end
end
