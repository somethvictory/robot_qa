class Color < ApplicationRecord
  COLORS = %w(red green blue)
  validates :name, presence: true

  has_many :robots

  COLORS.each do |color_name|
    define_method "#{color_name}?" do
      name == color_name
    end
  end
end
