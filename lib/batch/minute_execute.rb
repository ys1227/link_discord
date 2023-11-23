class Batch::MinuteExecute
  def self.outputText
    puts DateTime.now
    puts 'バッチから出力しています。'
  end
end
