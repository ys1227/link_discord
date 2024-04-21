require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe 'Voteの関連付けに関するテスト' do
    before do
      @user = FactoryBot.create(:user)
      @reservation = FactoryBot.create(:reservation)
      @vote = FactoryBot.create(:vote, user:@user, reservation: @reservation)
    end

    it 'userとの関連付けが正しく設定されていること' do
      expect(@vote.user).to eq @user
    end

    it 'reservationとの関連付けが正しく設定されていること' do
      expect(@vote.reservation).to eq @reservation
    end
  end
end