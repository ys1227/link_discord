class QuestionsController < ApplicationController
  skip_before_action :require_login,only: %i[index show]
  def new
    @question = Question.new
  end

  def index
    @questions = Question.includes(:user)
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
      redirect_to questions_path, success: '投稿が成功しました'
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

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
