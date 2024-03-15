class ReservationsController < ApplicationController
  skip_before_action :check_logged_in, only: %i[index_vote]
  before_action :set_question, only: %i[index new create bulk_update destroy index_vote]

  def index
    @reservation = Reservation.new
    @question_reservations = @question.reservations
  end

  def new
    @reservations = Reservation.all || []
    @reservation = Reservation.new
    @question_reservations = @question.reservations || []
  end

  def create
    @reservations = Reservation.all || []
    @reservation = @question.reservations.build(reservations_params)
    @question_reservations = @question.reservations || []
    if @reservation.save
      redirect_to new_question_reservation_path(@question), success: '募集時間が登録できました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def bulk_update
    @question_reservations = @question.reservations
    @question_reservations.each do |reservation|
      reservation.update_columns(rank: "default")
    end
    @reservations_params = second_reservation_params
    errors = []

    ActiveRecord::Base.transaction do
      @reservations_params.each do |reservation_param|
        reservation = Reservation.find(reservation_param[:id])
        reservation.rank = reservation_param[:rank]

        if reservation.valid?(:bulk_update)
          reservation.save!
        else
          reservation.errors.full_messages.each do |message|
            errors << "#{l reservation.start_time, format: :short} #{message}"
          end
        end
      end
    rescue ActiveRecord::RecordInvalid
      raise ActiveRecord::Rollback # トランザクションをロールバック
    end

    if errors.empty?
      redirect_to show_reservations_question_path(@question), success: '募集時間が登録できました'
    else
      flash.now[:danger] = errors.join(', ')
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy!

    redirect_to new_question_reservation_path(@question), status: :see_other
  end

  def index_vote
    @vote = Vote.new
    @question_reservations = @question.reservations.order(:rank)
    @user = @question.user_id
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

  def set_question
    @question = Question.find(params[:question_id])
  end
end
