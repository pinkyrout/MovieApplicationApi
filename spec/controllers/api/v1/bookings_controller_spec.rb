require 'rails_helper'

RSpec.describe Api::V1::BookingsController, type: :controller do
  describe 'GET index' do
    let!(:booking1) { FactoryBot.create(:booking) }
    let!(:booking2) { FactoryBot.create(:booking) }

    it 'returns list of all bookings sorted by descending order of created at' do
      get :index
      bookings = JSON.parse(response.body)

      expect(bookings.count).to eq(2)
      expect(bookings.pluck('id')).to eq([booking2.id, booking1.id])
    end
  end

  describe 'POST create' do
    let!(:show) { FactoryBot.create(:show) }
    let!(:seat1) { FactoryBot.create(:seat, show: show) }
    let!(:seat2) { FactoryBot.create(:seat, show: show) }

    it 'creates new booking record and updates the selected seats' do
      expect(Booking.count).to eq(0)
      expect(seat1.booking_id).to eq(nil)
      expect(seat2.booking_id).to eq(nil)

      post :create, params: {show_id: show.id, seat_ids: [seat1.id, seat2.id]}

      expect(Booking.count).to eq(1)
      expect(seat1.reload.booking_id).not_to eq(nil)
      expect(seat2.reload.booking_id).not_to eq(nil)
    end
  end
end
