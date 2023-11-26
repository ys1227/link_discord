require 'discordrb'

class  Batch::MinuteStateConfirm
  def self.update_question_state
    reservations = []
    puts DateTime.now
    Question.published.past_closed.find_each do |question|
    question.update!(state: "closed")
    question.matching_data_confirm
    end
  end

  # def self.bot_stop
  #   bot = Discordrb::Bot.new client_id: ENV['DISCORD_CLIENT_ID'], token: ENV['DISCORD_BOT_TOKEN'],intents: [:server_messages]
  #   self.run_bot
  #   bot.stop
  # end

  # def self.run_bot
  #   bot = Discordrb::Bot.new client_id: ENV['DISCORD_CLIENT_ID'], token: ENV['DISCORD_BOT_TOKEN'], intents: [:server_messages] 
  #   bot.run
  # end
end



