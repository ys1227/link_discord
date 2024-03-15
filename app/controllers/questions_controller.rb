class QuestionsController < ApplicationController
  skip_before_action :check_logged_in, only: %i[index show]
  before_action :set_question, only: %i[show edit update destroy show_reservations create_deadline choose_schedule ]

  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).includes(:user).order(deadline: :desc).where(state: %i[published closed])
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.build(question_params)
    @question.is_demo = true if current_user.is_guest?
    if @question.save
      redirect_to new_question_reservation_path(@question), success: '投稿が成功しました'
    else
      flash.now[:danger] = '投稿が失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      redirect_to questions_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy!

    redirect_to questions_path, status: :see_other
  end

  def show_reservations
    @question_reservatins = @question.reservations
  end

  def create_deadline
    @question_reservations = @question.reservations
    start_times = @question_reservations.map(&:start_time)
    eariest_start_time = start_times.min
    deadline = eariest_start_time - 12.hours

    if @question.valid?(:create_deadline)
      @question.update(deadline: deadline)
      @question.update(state: "published")
      if current_user.is_guest?
        DeleteGuestDateJob.set(wait: 5.seconds).perform_later(@question)
        redirect_to questions_path, success: 'ゲストとして投稿しました。投稿は5秒後に削除されます。'
        return
      end
      redirect_to questions_path, success: '募集を開始しました'
    else
      flash.now[:danger] = "希望順位が正しく設定されていません。戻るを押して設定し直してね。"
      render :show_reservations, status: :unprocessable_entity
    end
  end

  def choose_schedule
  end

  def draft
    @q = current_user.questions.draft.ransack(params[:q])
    @questions = @q.result(distinct: true).includes(:user).order(deadline: :desc)
  end

  def published
    @q = current_user.questions.published.draft.ransack(params[:q])
    @questions = @q.result(distinct: true).includes(:user).order(deadline: :desc)
  end

  def voted
    @voted_questions = current_user.vote_questions
    @q = @voted_questions.ransack(params[:q])
    @questions = @q.result(distinct: true).includes(:user).order(deadline: :desc)
  end

  private

  def question_params
    params.require(:question).permit(:title, :content, :role)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
