class Api::V1::SeatBlueprint < Blueprinter::Base
  identifier :id

  view :extended do
    fields :category, :price, :is_booked, :number
  end

  view :normal do
    fields :number
  end
end