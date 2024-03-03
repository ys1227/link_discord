require 'rails_helper'

RSpec.describe 'Discordログイン', type: :system do 
  context 'ユーザーがDiscordでログインする' do
    it '正常にログインできる' do
    visit root_path
    click_button 'Login with Discord'

    expect(page).to have_content('ログインに成功しました')
    end
  end
end
