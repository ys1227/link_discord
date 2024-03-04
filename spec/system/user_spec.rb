require 'rails_helper'

RSpec.describe 'Discordログイン', type: :system do 
  before do
    # `guild_member?`メソッドをモックにして常にtrueを返すように設定
    # rspec-mocksを使用
    allow(User).to receive(:guild_member?).and_return(true)
  end

  after do
    OmniAuth.config.mock_auth[:discord] = nil
    OmniAuth.config.test_mode = false
  end

  context 'ユーザーがDiscordでログインする' do
    it '正常にログインできる' do
    visit root_path
    click_button 'Login with Discord'

    expect(page).to have_content('ログインに成功しました')
    end
  end
end
