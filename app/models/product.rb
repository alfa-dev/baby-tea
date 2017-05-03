class Product < ApplicationRecord

	belongs_to :user, required: false

	validates :name, presence: true

	def self.default_scope
    	where(enabled: true)
  	end

  	scope :include_disabled, -> { unscope(:where) }
  	scope :diaper, -> { where(category: 'diaper') }
  	scope :low,    -> { where(category: 'low') }
  	scope :med,    -> { where(category: 'med') }
  	scope :high,   -> { where(category: 'high') }
end
