class CreateShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows do |t|
      t.integer :start_time
      t.integer :end_time
      t.date    :date
      t.boolean :is_full
      t.string  :screen

      t.references :movie
      t.timestamps
    end
  end
end
 