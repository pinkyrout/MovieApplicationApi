class AddShowInSeat < ActiveRecord::Migration[6.0]
  def change
    add_reference :seats, :show, foreign_key: true
  end
end
