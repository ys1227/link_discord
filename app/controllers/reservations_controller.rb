class ReservationsController < ApplicationController
  def index
    @question = Question.find(params[:question_id])
    @reservation = Reservation.new
    @question_reservations = @question.reservations

  end

  def new
    @question = Question.find(params[:question_id])
    @reservations = Reservation.all || []
    @reservation = Reservation.new
    @question_reservations = @question.reservations || []
  end

  def create
    @reservations = Reservation.all || []
    @question = Question.find(params[:question_id])
    @reservation = @question.reservations.build(reservations_params)
    @question_reservations = @question.reservations || []
    if @reservation.save
      redirect_to new_question_reservation_path(@question), success: '募集時間が登録できました'
    else
      flash.now[:danger] ="投稿に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @question = Question.find(params[:question_id])
    @reservations = @question.reservations

    if @reservations.update(second_reservation_params)
      redirect_to questions_path, success: '募集時間が登録できました'
    else
      flash.now[:danger] ="投稿に失敗しました"
      render :index, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @question = Question.find(params[:question_id])
    @reservation = Reservation.find(params[:id])
    @reservation.destroy!

    redirect_to new_question_reservation_path(@question), status: :see_other
  end
  
  private
  
  def reservations_params
    params.require(:reservation).permit(:rank, :start_time)
  end

  def second_reservation_params
    params.require(:reservation).permit(:rank)
  end
end
