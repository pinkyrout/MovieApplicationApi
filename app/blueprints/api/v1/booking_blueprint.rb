class Api::V1::BookingBlueprint < Blueprinter::Base
  identifier :id

  view :extended do
    fields :price
  end

  field :show_start_time do |booking|
    booking.show.start_time
  end

  field :movie_name do |booking|
    booking.show.movie.name
  end

  association :seats, blueprint: Api::V1::SeatBlueprint, view: :normal do |booking|
    booking.seats
  end
end
