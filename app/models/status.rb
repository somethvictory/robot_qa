class Status < ApplicationRecord
  STATUSES = %w(on_fire rusty loose_screws paint_scratched)
  validates :name, presence: true

  has_and_belongs_to_many :robots

  class << self
    STATUSES.each do |status_name|
      define_method "#{status_name}" do
        find_by(name: status_name)
      end
    end
  end
end
