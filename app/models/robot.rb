class Robot < ApplicationRecord
  MIN_ROTORS = 3
  MAX_ROTORS = 8

  validates :name, presence: true
  validates :color, presence: true

  belongs_to :color
  belongs_to :shipment, optional: true

  delegate :blue?, to: :color

  has_and_belongs_to_many :statuses

  def self.non_shipped
    where(shipment_id: nil)
  end

  def self.shippable
    joins(:color)
    .joins(:statuses)
    .where("(robots.number_of_rotors >= #{MIN_ROTORS} AND robots.number_of_rotors <= #{MAX_ROTORS}) AND
      (colors.name != 'blue') AND
      (robots.has_wheels = false OR robots.has_tracks = false) AND
      (robots.has_wheels = false OR statuses.name != 'rusty') AND
      (robots.has_sentience = false OR statuses.name != 'loose_screws') AND
      statuses.name != 'on_fire'"
    )
    .distinct
  end

  def self.factory_second
    shippable.where(statuses: {name: ['loose_screws', 'paint_scratched']})
  end

  def self.qa_passed
    shippable - factory_second
  end

  def color_name
    color.name
  end

  def status_names
    @names ||= statuses.pluck(:name)
  end

  def should_recycle?
    on_fire? || invalid_rotors?  ||
    (has_rotors? && blue?) ||
    (has_wheels? && has_tracks?) ||
    (has_wheels && rusty?)       ||
    (has_sentience? && loose_screws?)
  end

  def rusty?
    statuses.rusty.present?
  end

  def loose_screws?
    statuses.loose_screws.present?
  end

  def paint_scratched?
    statuses.paint_scratched.present?
  end

  def on_fire?
    statuses.on_fire.present?
  end

  def has_rotors?
    number_of_rotors > 0
  end

  def valid_rotors?
    number_of_rotors >= MIN_ROTORS && number_of_rotors <= MAX_ROTORS
  end

  def invalid_rotors?
    !valid_rotors?
  end
end
