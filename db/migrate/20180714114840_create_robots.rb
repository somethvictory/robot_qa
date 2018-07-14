class CreateRobots < ActiveRecord::Migration[5.1]
  def change
    create_table :robots do |t|
      t.string     :name,             default: ''
      t.boolean    :has_sentience,    default: false
      t.boolean    :has_wheels,       default: false
      t.boolean    :has_tracks,       default: false
      t.integer    :number_of_rotors, default: 0
      t.references :color
    end
  end
end
