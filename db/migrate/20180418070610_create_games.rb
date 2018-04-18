class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :state
      t.string :difficulty
      t.json :board
      t.json :timers

      t.timestamps
    end
  end
end
