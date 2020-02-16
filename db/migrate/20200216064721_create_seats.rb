class CreateSeats < ActiveRecord::Migration[6.0]
  def change
    create_table :seats do |t|
      t.string       :category
      t.float        :price
      t.boolean      :is_booked, default: false
      
      t.references   :booking
      t.timestamps
    end
  end
end
