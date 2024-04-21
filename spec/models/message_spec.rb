require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'messageの関連付けに関するテスト' do
    before do
      @user = FactoryBot.create(:user)
      @question = FactoryBot.create(:question, user: @user)
      @message = FactoryBot.create(:message, user: @user, question:@question)
    end

    it 'userとの関連付けが正しく設定されていること' do
      expect(@message.user).to eq @user
    end

    it 'questionとの関連付けが正しく設定されていること' do
      expect(@message.question).to eq @question
    end
  end
end