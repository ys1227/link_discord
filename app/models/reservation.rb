class Reservation < ApplicationRecord
  belongs_to :question
  enum rank: { default:0, one:10, two:20, three:30 }

  validates :start_time, presence:true
  validate :start_check
  validate :reservation_count_check
  validate :rank_count_check, on: :bulk_update
  validate :rank_not_default_check, on: :bulk_update
  validate :reservation_time_check, on: :create

  #validate :deadline_check


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

  # def deadline_check
  #   @question = Question.find(self.question.id)
  #   selected_datetime = DateTime.new(
  #     start_time.year,
  #     start_time.month,
  #     start_time.day,
  #     start_time.hour,
  #     start_time.min,
  #     0, # 秒は0秒として扱いますが、必要に応じて変更
  #     Rails.application.config.time_zone # アプリケーションのタイムゾーンに合わせます
  #   )
  #   if selected_datetime <= @question.deadline
  #     errors.add(:start_time, "は募集締め切りに設定した時間より遅い時間を選択してください")
  #   end
  # end

  def reservation_count_check
    @question = Question.find(self.question.id)
      @saved_question_reservation = @question.reservations.count
      if @saved_question_reservation > 3
        errors.add(:start_time,"は3つまでしか登録できません")
      end
  end

  def reservation_time_check
    start_times = []
    @question = Question.find(self.question.id)
    @question_reservations = @question.reservations
      @question.reservations.each do |reservation|
        start_times << reservation.start_time
      end
    if  start_times.include?(self.start_time)
      errors.add(:start_time,"が重複して登録されています。")
    end
  end
  #{ id: data[:id], rank: data[:rank] }

  def rank_count_check
    @question = Question.find(self.question.id)
    ranks = []
    @question_reservations = @question.reservations
      @question.reservations.each do |reservation|
        ranks << reservation.rank
      end
    if  ranks.include?(self.rank && self.rank != "default")
      errors.add(:rank,"が重複して登録されています。")
    end
  end

  def rank_not_default_check
    @question = Question.find(self.question.id)
    if self.rank == "default"
      errors.add(:rank,"が-になっています。")
    end
  end

end
