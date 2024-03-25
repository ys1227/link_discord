require 'rails_helper'

RSpec.describe Question, type: :model do
  describe '投稿のバリデーションに関するテスト' do
    it 'title,content,roleがある場合は有効' do
      valid_question = FactoryBot.create(:question)
      expect(valid_question).to be_valid
    end

    it 'titleがない場合は無効' do
      question_without_title = FactoryBot.build(:question, title: '')
      expect(question_without_title).to be_invalid
    end

    it 'contentがない場合は無効' do
      question_without_content = FactoryBot.build(:question, content: '')
      expect(question_without_content).to be_invalid
    end

    it 'roleがない場合は無効' do
      question_without_role = FactoryBot.build(:question, role: '')
      expect(question_without_role).to be_invalid
    end

    it 'titleは30文字以内であること' do
      question = FactoryBot.create(:question)
      question.title = 'a' * 31
      expect(question).to_not be_valid
    end

    it 'contentは60文字以内であること' do
      question = FactoryBot.create(:question)
      question.title = 'a' * 61
      expect(question).to_not be_valid
    end
  end

  describe 'ユーザーの関連付けに関するテスト' do
    before do
      @user = FactoryBot.create(:user)
      @another_user = FactoryBot.create(:user)
      @question = FactoryBot.create(:question, :with_reservation, user: @user)
      @reservation = FactoryBot.create(:reservation, question: @question)
      @message = FactoryBot.create(:message, user: @user, question:@question)
      @vote = FactoryBot.create(:vote, user:@another_user, reservation: @reservation)
    end

    it 'messageとの関連付けが正しく設定されていること' do
      expect(@question.messages).to include @message
    end

    it 'reservationとの関連付けが正しく設定されていること' do
      expect(@question.reservations).to include @reservation
    end
  end
end
