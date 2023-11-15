class Reservation < ApplicationRecord
  belongs_to :question
  enum rank: { one:0, two:10, three:20}

  validates :start_time, presence:true
  validate :start_check
  validate :deadline_check

  def start_check
    selected_datetime = DateTime.new(
      start_time.year,
      start_time.month,
      start_time.day,
      start_time.hour,
      start_time.min,
      0,
      Rails.application.config.time_zone # アプリケーションのタイムゾーンに合わせます
    )
  
    if selected_datetime <= DateTime.current
      errors.add(:start_time, "は現在の時間より遅い時間を選択してください")
    end
  end

  def deadline_check
    @question = Question.find(self.question.id)
    selected_datetime = DateTime.new(
      start_time.year,
      start_time.month,
      start_time.day,
      start_time.hour,
      start_time.min,
      0, # 秒は0秒として扱いますが、必要に応じて変更
      Rails.application.config.time_zone # アプリケーションのタイムゾーンに合わせます
    )
    if selected_datetime <= @question.deadline
      errors.add(:start_time, "は募集締め切りに設定した時間より遅い時間を選択してください")
    end
  end
end
