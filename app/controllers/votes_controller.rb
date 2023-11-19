class VotesController < ApplicationController

  def index
  end

  def create
    question = Question.find(params[:question_id])
    reservation = Reservation.find(params[:reservation_id])
    @vote = current_user.vote(reservation)
      redirect_to index_vote_question_reservations_path(question), success: '投稿が成功しました'
  end

  def update
  end

  def destroy
  end
  
end
