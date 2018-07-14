class CreateRobotsStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :robots_statuses do |t|
      t.references :robot
      t.references :status
    end
  end
end
