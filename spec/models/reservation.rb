require 'rails_helper'

RSpec.describe Question, type: :model do
  describe '予約のバリデーションに関するテスト' do
    it 'start_timeがある場合は有効' do
      valid_reservation = FactoryBot.create(:reservation)
      expect(valid_reservation).to be_valid
    end
  end

  describe '予約の関連付けに関するテスト' do
    before do
      @question = FactoryBot.create(:question)
      @matching_time = FactoryBot.create(:matching_time)
      @reservation = FactoryBot.create(:reservation, question:@question, matching_time: @matching_time)
      @vote = FactoryBot.create(:vote, reservation:@reservation)
    end

    it 'questionとの関連付けが正しく設定されていること' do
      expect(@reservation.question).to eq @question
    end

    it 'voteとの関連付けが正しく設定されていること' do
      expect(@reservation.votes).to include @vote
    end

    it 'matching_timeとの関連付けが正しく設定されていること' do
      expect(@reservation.matching_time).to eq @matching_time
    end
  end

  describe 'ユーザーのenum値に関するテスト' do
    before do 
      @reservation = FactoryBot.create(:reservation)
    end
    it 'enumで定義したrankの値がモデルに正しく設定されるか' do
      expect(@reservation.rank).to eq 'default'
    end

    it 'rankに関するenumのメソッドが正しく定義されているか' do
      expect(@reservation).to respond_to(:default?)
      expect(@reservation).to respond_to(:one?)
      expect(@reservation).to respond_to(:two?)
      expect(@reservation).to respond_to(:three?)
    end

    it 'rankをメソッドを使用して正しく変更できるか' do
      @reservation.default!
      expect(@reservation.rank).to eq 'default'
      @reservation.one!
      expect(@reservation.rank).to eq 'one'
      @reservation.two!
      expect(@reservation.rank).to eq 'two'
      @reservation.three!
      expect(@reservation.rank).to eq 'three'
    end
  end
end