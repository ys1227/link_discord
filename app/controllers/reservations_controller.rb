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

  def bulk_update
    @question = Question.find(params[:question_id])
    @question_reservations = @question.reservations || []
    @reservations_params = second_reservation_params
    ActiveRecord::Base.transaction do
      @reservations_params.each do |reservation_param|
        reservation = Reservation.find(reservation_param[:id])
        reservation.update!(rank: reservation_param[:rank])
      end
    end

    redirect_to questions_path, success: '募集時間が登録できました'
    rescue ActiveRecord::RecordInvalid
      flash.now[:danger] = "投稿に失敗しました"
      render :index, status: :unprocessable_entity
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
    permitted_params = params.require(:reservations).permit!
    reservations_params = permitted_params.to_h.map do |_, data|
      { id: data[:id], rank: data[:rank] }
    end
  end
end


