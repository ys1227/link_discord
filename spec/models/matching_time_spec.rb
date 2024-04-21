require 'rails_helper'

RSpec.describe MatchingTime, type: :model do
  describe 'matching_timeの関連付けに関するテスト' do
    before do
      @user = FactoryBot.create(:user)
      @question = FactoryBot.create(:question, user: @user)
      @reservation = FactoryBot.create(:reservation)
      @matching_time = FactoryBot.create(:matching_time, question:@question, reservation:@reservation)
    end

    it 'questionとの関連付けが正しく設定されていること' do
      expect(@matching_time.question).to eq @question
    end

    it 'reservationとの関連付けが正しく設定されていること' do
      expect(@matching_time.reservation).to eq @reservation
    end
  end
end