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

  describe 'スコープに関するテスト' do
    before do
      @past_created_question = FactoryBot.create(:question, :past)
    end

    it '締め切り時間が現在の時間よりも前のquestionを返すこと' do
      expect(Question.all.past_closed).to include(@past_created_question)
    end
  end

  describe 'ユーザーのenum値に関するテスト' do
    before do 
      @question = FactoryBot.create(:question)
    end
    it 'enumで定義したroleの値がモデルに正しく設定されるか' do
      expect(@question.role).to eq 'inquiry'
    end

    it 'enumで定義したstateの値がモデルに正しく設定されるか' do
      expect(@question.state).to eq 'published'
    end

    it 'roleに関するenumのメソッドが正しく定義されているか' do
      expect(@question).to respond_to(:inquiry?)
      expect(@question).to respond_to(:small_talk?)
      expect(@question).to respond_to(:job_serching?)
      expect(@question).to respond_to(:portfolio?)
      expect(@question).to respond_to(:others?)
    end

    it 'roleをメソッドを使用して正しく変更できるか' do
      @question.inquiry!
      expect(@question.role).to eq 'inquiry'
      @question.small_talk!
      expect(@question.role).to eq 'small_talk'
      @question.job_serching!
      expect(@question.role).to eq 'job_serching'
      @question.portfolio!
      expect(@question.role).to eq 'portfolio'
      @question.others!
      expect(@question.role).to eq 'others'
    end

    it 'stateに関するenumのメソッドが正しく定義されているか' do
      expect(@question).to respond_to(:draft?)
      expect(@question).to respond_to(:published?)
      expect(@question).to respond_to(:closed?)
    end

    it 'stateをメソッドを使用して正しく変更できるか' do
      @question.draft!
      expect(@question.state).to eq 'draft'
      @question.published!
      expect(@question.state).to eq 'published'
      @question.closed!
      expect(@question.state).to eq 'closed'
    end

  end
end
