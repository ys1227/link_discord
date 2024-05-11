require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let(:question) { FactoryBot.create(:question) }

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context '投稿作成画面にアクセス' do
        it '正常にアクセスができない' do
          visit new_question_path
          expect(current_path).to eq root_path
        end
      end

      context '投稿一覧画面にアクセス' do
        it '正常にアクセスができる' do
          visit questions_path
          expect(current_path).to eq questions_path
        end
      end

      context '投稿一覧画面にアクセス' do
        it '正常にアクセスができる' do
          visit questions_path
          expect(current_path).to eq questions_path
        end
      end

      context '質問詳細画面にアクセス' do
        it '正常に質問詳細画面にアクセスができる' do
          visit question_path(question)
          expect(current_path).to eq question_path(question)
        end
      end
    end
  end
end