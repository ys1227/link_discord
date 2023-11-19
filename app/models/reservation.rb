class Reservation < ApplicationRecord
  belongs_to :question
  has_many :votes, dependent: :destroy
  
  enum rank: { default:0, one:10, two:20, three:30 }

  validates :start_time, presence:true
  validate :start_check
  validate :reservation_count_check, on: :create
  validate :reservation_time_check, on: :create
  validate :rank_count_check, on: :bulk_update
  validate :rank_not_default_check, on: :bulk_update
  validate :rank_not_same_check, on: :create_deadline


  def start_check
    selected_datetime = DateTime.new(
      start_time.year,
      start_time.month,
      start_time.day,
      start_time.hour,
      start_time.min,
      0,
      Rails.application.config.time_zone 
    )
  
    if selected_datetime <= DateTime.current
      errors.add(:start_time, "は現在の時間より遅い時間を選択してください")
    end
  end

  def reservation_count_check
    @question = Question.find(self.question.id)
      @saved_question_reservation = @question.reservations.count
      if @saved_question_reservation >= 3
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
    if start_times.include?(self.start_time)
      errors.add(:start_time,"が重複して登録されています。")
    end
  end

  #{ id: data[:id], rank: data[:rank] }

  def rank_count_check
    @question = Question.find(self.question_id)
    existing_ranks = @question.reservations.where.not(id: self.id).pluck(:rank)

    if existing_ranks.include?(self.rank) && self.rank != "default"
      errors.add(:rank, "が重複して登録されています。もう一度選択し直してください。")
    end
  end

  def rank_not_default_check
    @question = Question.find(self.question.id)
    if self.rank == "default"
      errors.add(:rank,"が-になっています。")
    end
  end

  def rank_not_same_check
    question = Question.find(self.question_id)
    question_reservations = question.reservations
    ranks_array = []
    question.reservations.each do |reservation|
      ranks_array << reservation.rank
    end
    valid_arrays = [
    ["one"],
    ["one", "two"],
    ["two", "one"],
    ["one", "two", "three"],
    ["one", "three", "two"],
    ["two", "one", "three"],
    ["two", "three", "one"],
    ["three", "two", "one"],
    ["three", "one", "two"]
  ]

    unless valid_arrays.include?(ranks_array)
      errors.add(:rank, "希望順位が正しくありません")
    end
  end
end
