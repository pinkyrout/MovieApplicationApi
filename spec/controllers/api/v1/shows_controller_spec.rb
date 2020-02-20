require 'rails_helper'

RSpec.describe Api::V1::ShowsController, type: :controller do
  describe 'GET index' do
    let!(:show1) { FactoryBot.create(:show) }
    let!(:show2) { FactoryBot.create(:show) }

    it 'returns list of all shows in descending order of id' do
      get :index
      shows = JSON.parse(response.body)

      expect(shows.count).to eq(2)
      expect(shows.pluck('id')).to eq([show2.id, show1.id])
    end
  end

  describe 'GET seats' do
    let!(:show) { FactoryBot.create(:show) }
    let!(:seat) { FactoryBot.create_list(:seat, 20, show: show) }

    context 'when params have is_admin flag' do
      it 'returns show seats per page with total count of seats' do
        get :seats, params: { id: show.id, is_admin: true }
        res = JSON.parse(response.body)

        expect(res['seats'].count).to eq(10)
        expect(res['count']).to eq(20)
      end
    end

    context 'when params does not have is_admin flag' do
      it 'returns list of all seats for the show with total count of seats' do
        get :seats, params: { id: show.id }
        res = JSON.parse(response.body)

        expect(res['seats'].count).to eq(20)
        expect(res['count']).to eq(20)
      end
    end

    it 'returns show details' do
      get :seats, params: { id: show.id }
      movie_show = JSON.parse(response.body)['show']

      expect(movie_show['id']).to eq(show.id)
    end
  end

  describe 'POST download_report' do
    let!(:show) { FactoryBot.create(:show) }
    let!(:seat1) { FactoryBot.create(:seat, show: show) }
    let!(:seat2) { FactoryBot.create(:seat, show: show) }

    it 'generates xlsx file for the show report and returns the file path' do
      post :download_report, params: { id: show.id }

      res = JSON.parse(response.body)
      file_path = res['data']['file_path']
      file = Roo::Spreadsheet.open("#{Rails.root}/public/#{file_path}", extension: :xlsx)

      expect(File.exist?("#{Rails.root}/public/#{file_path}")).to eq(true)
      expect(file.row(1)).to eq(['Seat Id', 'Seat Category', 'Seat Number', 'Booked'])
      expect(file.column(1)).to eq(["Seat Id", seat1.id, seat2.id])
    end
  end
end
