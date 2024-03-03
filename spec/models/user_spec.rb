require 'rails_helper'

RSpec.describe 'User', type: :model do
  describe 'ユーザーのバリデーションに関するテスト' do
    it '名前、メールアドレスがある場合は有効' do
      valid_user = FactoryBot.build(:user)
      expect(valid_user).to be_valid
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
    end

    it 'questionとの関連付けが正しく設定されていること' do
      question = FactoryBot.create(:question, user: @user)
      expect(@user.question).to include question
    end
  end
end