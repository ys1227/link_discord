require 'discordrb'

# Bot を作成
# bot = Discordrb::Bot.new client_id: ENV['DISCORD_CLIENT_ID'], token: ENV['DISCORD_BOT_TOKEN'],intents: [:server_messages]

# メッセージの投稿に反応して実行するメソッドを定義
# bot.message(content: 'Ping!') do |event|
#   event.respond 'Pong!'
# end


# bot.message(with_text: '!dm') do |event|
#   user_id = event.user.id # ユーザーのIDを取得
#   user = bot.user(user_id) # IDからユーザーオブジェクトを取得
#   user.dm('ここにDMの内容を入れる') # ユーザーにDMを送る
# end


# Bot を実行
# bot.run
bot.stop
