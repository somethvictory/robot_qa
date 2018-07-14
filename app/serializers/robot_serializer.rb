class RobotSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :configuration

  def configuration
    {
      hasSentience:   object.has_sentience,
      hasWheels:      object.has_wheels,
      hasTracks:      object.has_tracks,
      numberOfRotors: object.number_of_rotors,
      color:          object.color_name.titleize,
      statuses:       object.status_names.map { |s| s.titleize }
    }
  end
end
