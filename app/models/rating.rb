class Rating < ApplicationRecord
  belongs_to :ride, optional: false
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :review, length: { maximum: 500 }, allow_blank: true
end
