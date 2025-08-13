class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  SCORES_RANGE = 1..5

  validates :score, inclusion: {in: SCORES_RANGE}
end
