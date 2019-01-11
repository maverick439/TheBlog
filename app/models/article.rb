class Article < ApplicationRecord
	validates :title, presence: true, length: { minimum: 1, maximum: 50 }
	validates :description, presence: true, length: { minimum: 10, maximum: 300 }
	
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	belongs_to :user
end
