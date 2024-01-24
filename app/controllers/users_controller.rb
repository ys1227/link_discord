class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def show
    @questions = current_user.questions
  end
end
