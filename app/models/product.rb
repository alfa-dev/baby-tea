class Product < ApplicationRecord

	belongs_to :user, required: false

	validates :name, presence: true

  DIAPER_ORDERED = ['Tamanho RN', 'Tamanho P', 'Tamanho M', 'Tamanho G']

	def self.default_scope
    where(enabled: true)
  end

	scope :include_disabled, -> { unscope(:where) }
	scope :diaper, -> { where(category: 'diaper').by_name }
  scope :low,    -> { where(category: 'low') }
  scope :med,    -> { where(category: 'med') }
  scope :high,   -> { where(category: 'high') }

  scope :by_name, -> { order(order_by_case) }

  private

  def self.order_by_case
    ret = "CASE"
    DIAPER_ORDERED.each_with_index do |p, i|
      ret << " WHEN name = '#{p}' THEN #{i}"
    end
    ret << " END"
  end

end
