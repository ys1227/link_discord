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
      expect(@user.questions).to include question
    end
  end
end