class Task < ApplicationRecord
  acts_as_paranoid
  has_paper_trail on: %i[update destroy]

  belongs_to :user

  enum priority: %i[low medium high]
  enum status: %i[todo in_progress review done cancelled]

  scope :updated_today, -> { where('updated_at >= ?', Time.current.beginning_of_day) }
  scope :by_priority, ->(value) { send(value) if value.in?(priorities.keys) }

  validates_presence_of :title, :description, :priority, :status
end
