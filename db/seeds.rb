colors = ['red', 'green', 'blue'].map do |color|
  Color.find_or_create_by!(name: color)
end

statuses = ['on_fire', 'rusty', 'loose_screws', 'paint_scratched'].map do |status|
  Status.find_or_create_by!(name: status)
end

1000.times do |i|
  robot = Robot.find_or_initialize_by(
    name:             "Robot #{i+1}",
    color:            colors.sample,
    has_sentience:    [true, false].sample,
    has_wheels:       [true, false].sample,
    has_tracks:       [true, false].sample,
    number_of_rotors: rand(20),
  )
  robot.statuses = statuses.sample(1 + rand(3)) if robot.new_record?
  robot.save
end
