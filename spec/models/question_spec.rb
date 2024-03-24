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
end
