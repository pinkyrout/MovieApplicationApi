class Api::V1::BookingsController < ApplicationController
  def index
    bookings = Api::V1::BookingBlueprint.render Booking.order(created_at: :desc).includes([{ show: :movie }, :seats]), view: :extended
    render json: bookings
  end

  def create
    booked_seats = Seat.where(id: params[:seat_ids])
    booking = Booking.new(show_id: params[:show_id], price: booked_seats.pluck(:price).sum)
    booking.save
    booked_seats.update_all(booking_id: booking.id, is_booked: true)
    head :ok
  end
end
