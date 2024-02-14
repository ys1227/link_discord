require 'rails_helper'

Rspec.describe 'Discordログイン', type: :system do 
  context 'ユーザーがDiscordでログインする' do
    visit root_path
    click_on 'Login with Discord'

    expect(page).to have_content('ログインに成功しました')
  end
end