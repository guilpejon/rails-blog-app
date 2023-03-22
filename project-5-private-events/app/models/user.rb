class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_events, class_name: 'Event'
  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event
end
