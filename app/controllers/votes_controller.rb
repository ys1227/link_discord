class VotesController < ApplicationController

  def index
  end

  def create
    @question = Question.find(params[:question_id])
    @question_reservations = @question.reservations
    reservation = Reservation.find(params[:reservation_id])
    @vote = current_user.votes.build(reservation: reservation)
    if @vote.save
      redirect_to questions_path, success: '投稿が成功しました'
    else
      flash.now[:danger] ="投稿に失敗しました"
      render 'reservations/index_vote', status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end
  
end
