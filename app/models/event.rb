class Event < ApplicationRecord
  belongs_to :user
  validates :title, :description, :startTime, :endTime, :date, presence: true
  validates :category, presence: true, inclusion: { in: %w[movie music sport comedy] }
  enum category: %i[movie music sport comedy]
end
