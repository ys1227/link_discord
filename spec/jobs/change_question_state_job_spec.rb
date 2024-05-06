require 'rails_helper'

RSpec.describe ChangeQuestionStateJob, type: :worker do
  describe '#perform' do
  let!(:question1) { FactoryBot.create(:question, state: 'published', deadline: 1.day.ago) }
  let!(:question2) { FactoryBot.create(:question, state: 'published', deadline: 1.day.ago) }

    it '現在時刻より前に投稿されたquestionがjobの実行によってstateカラムを正しい状態に変化させるか' do

      described_class.perform_now
      expect(question1.reload.state).to eq("closed")
      expect(question2.reload.state).to eq("closed")
    end
  end
end