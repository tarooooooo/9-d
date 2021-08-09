class Message < ApplicationRecord
  validates :body, length: {maximum: 140}, presence: true

  belongs_to :user
  belongs_to :room
end
