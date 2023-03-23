class Event < ApplicationRecord
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attendances, source: :user

  scope :upcoming, -> { where("date >= ?", Time.zone.now).order(date: :asc) }
  scope :past, -> { where("date < ?", Time.zone.now).order(date: :desc) }

  # def self.past
  #   where("date >= ?", Time.zone.now).order(date: :asc)
  # end
  #
  # def self.upcoming
  #   where("date < ?", Time.zone.now).order(date: :desc)
  # end
end
