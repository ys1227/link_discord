class QuestionsController < ApplicationController
  skip_before_action :check_logged_in,only: %i[index show]
  def new
    @question = Question.new
  end

  def index
    @questions = Question.includes(:user).where(is_closed: false)
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy!

    redirect_to questions_path, status: :see_other
  end

  def create 
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to new_question_reservation_path(@question), success: '投稿が成功しました'
    else
      flash.now[:danger] ='投稿が失敗しました' 
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      redirect_to questions_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show_reservations
    @question = Question.find(params[:id])
    @question_reservatins = @question.reservations
  end

  def create_deadline
    @question = Question.find(params[:id])
    @question_reservations = @question.reservations
    start_times = @question_reservations.map(&:start_time)
    eariest_start_time = start_times.min
    deadline = eariest_start_time - 24.hours

    if @question.valid?(:create_deadline)
      @question.update(deadline: deadline)
      @question.update(is_closed: false)
      redirect_to questions_path, success: '募集を開始しました'
    else
      flash.now[:danger] = "希望順位が正しく設定されていません。戻るを押して設定し直してね。"
      render :show_reservations, status: :unprocessable_entity
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :content, :role)
  end
end
