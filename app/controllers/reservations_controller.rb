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
  end

  def create
    @reservations = Reservation.all || []
    @question = Question.find(params[:question_id])
    @reservation = @question.reservations.build(reservations_params)
    if @reservation.save
      redirect_to question_reservations_path, success: '募集時間が登録できました'
    else
      flash.now[:danger] ="投稿に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    
  end

  def show
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy!

    redirect_to question_reservations_path, status: :see_other
  end
  
  private
  
  def reservations_params
    params.require(:reservation).permit(:rank, :start_time)
  end

end
