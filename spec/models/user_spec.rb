require 'rails_helper'

RSpec.describe 'User', type: :model do
  describe 'ユーザーのバリデーションに関するテスト' do
    it '名前、メールアドレス、uidがある場合は有効' do
      valid_user = FactoryBot.build(:user)
      expect(valid_user).to be_valid
    end

    it '名前がない場合は無効' do
      user_without_name = FactoryBot.build(:user, name: '')
      expect(user_without_name).to be_invalid
    end

    it 'メールアドレスがない場合は無効' do
      user_without_email = FactoryBot.build(:user, email: '')
      expect(user_without_email).to be_invalid
    end

    it 'uidがない場合は無効' do
      user_without_uid = FactoryBot.build(:user, uid: '')
      expect(user_without_uid).to be_invalid
    end

    it '重複したメールアドレスは無効' do
      user = FactoryBot.create(:user)
      user_deplicate_email = FactoryBot.build(:user, email: user.email)
      expect(user_deplicate_email).to be_invalid
    end
  end

  describe 'ユーザーの関連付けに関するテスト' do
    before do
      @user = FactoryBot.create(:user)
      @another_user = FactoryBot.create(:user)
      @question = FactoryBot.create(:question, :with_reservation, user: @user)
      @reservation = FactoryBot.create(:reservation, question: @question)
      @message = FactoryBot.create(:message, user: @user)
      @vote = FactoryBot.create(:vote, user:@another_user, reservation: @reservation)
    end

    it 'questionとの関連付けが正しく設定されていること' do
      expect(@user.questions).to include @question
    end

    it 'messageとの関連付けが正しく設定されていること' do
      expect(@user.messages).to include @message
    end

    it 'voteとの関連付けが正しく設定されていること' do
      expect(@another_user.votes).to include @vote
    end

    it 'vote_reservationの関連付けが正しくなされていること' do
      expect(@another_user.vote_reservations).to include @reservation
    end

    it 'vote_questionの関連付けが正しくなされていること' do
      expect(@another_user.vote_questions).to include @question
    end
  end

  describe 'スコープに関するテスト' do
    before do
      @past_created_user = FactoryBot.create(:user, :past)
      @future_created_user = FactoryBot.create(:user, :future)
    end

    it 'past_hour_user_createは過去1時間以内に作成されたユーザーを返すこと' do 
      expect(User.all.past_hour_user_create).to include(@past_created_user)
      expect(User.all.past_hour_user_create).not_to include(@future_created_user)
    end
  end

  describe 'ログインの処理に関するテスト' do
    it 'auth_hashからユーザーを見つけるか作成するロジックのテスト' do

    end

    it '指定のサーバーにユーザーが存在するかどうかをチェックするメソッドのテスト' do
      
    end
  end
end