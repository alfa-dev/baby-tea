class Product < ApplicationRecord

	belongs_to :user, required: false

	validates :name, presence: true
end
