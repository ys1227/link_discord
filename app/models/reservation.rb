class Reservation < ApplicationRecord
  belongs_to :question
  has_one :matching_time, dependent: :destroy
  has_many :votes, dependent: :destroy

  enum rank: { default: 0, one: 10, two: 20, three: 30 }

  validates :start_time, presence: true
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

    if selected_datetime <= DateTime.current + 24.hours
      errors.add(:start_time, "は現在の時間より24時間遅い時間を選択してください")
    end
  end

  def reservation_count_check
    @question = Question.find(question.id)
    @saved_question_reservation = @question.reservations.count
    errors.add(:start_time, "は3つまでしか登録できません") if @saved_question_reservation >= 3
  end

  def reservation_time_check
    start_times = []
    @question = Question.find(question.id)
    @question_reservations = @question.reservations
    @question.reservations.each do |reservation|
      start_times << reservation.start_time
    end
    errors.add(:start_time, "が重複して登録されています。") if start_times.include?(start_time)
  end

  def rank_count_check
    @question = Question.find(question_id)
    existing_ranks = @question.reservations.where.not(id:).pluck(:rank)

    errors.add(:rank, "が重複して登録されています。もう一度選択し直してください。") if existing_ranks.include?(rank) && rank != "default"
  end

  def rank_not_default_check
    @question = Question.find(question.id)
    errors.add(:rank, "が-になっています。") if rank == "default"
  end

  def rank_not_same_check
    question = Question.find(question_id)
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

    errors.add(:rank, "希望順位が正しくありません") unless valid_arrays.include?(ranks_array)
  end
end
