require 'rails_helper'

RSpec.describe Api::V1::ShowsController, type: :controller do
  describe 'GET seats' do
    let!(:show) { FactoryBot.create(:show) }
    let!(:seat) { FactoryBot.create(:seat, show: show) }

    it 'returns list of all seats for a show' do
      get :seats, params: { id: show.id }
      seats = JSON.parse(response.body)

      expect(seats.count).to eq(1)
      expect(seats.first['id']).to eq(seat.id)
    end
  end
end