class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :comment_content , presence: true
end
