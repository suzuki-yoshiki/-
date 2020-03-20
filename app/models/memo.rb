class Memo < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :note, presence: true, length: { maximum: 100 }
end
