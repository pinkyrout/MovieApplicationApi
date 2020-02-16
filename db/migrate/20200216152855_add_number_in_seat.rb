class AddNumberInSeat < ActiveRecord::Migration[6.0]
  def change
    add_column :seats, :number, :string
  end
end
