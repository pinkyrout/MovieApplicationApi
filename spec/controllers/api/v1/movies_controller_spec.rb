require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :controller do
  describe 'GET index' do
    let!(:movie1) { FactoryBot.create(:movie) }
    let!(:movie2) { FactoryBot.create(:movie) }

    it 'returns list of all movies' do
      get :index
      movies = JSON.parse(response.body)

      expect(movies.count).to eq(2)
      expect(movies.pluck('id')).to match_array([movie1.id, movie2.id])
    end
  end

  describe 'GET upcoming_shows' do
    let!(:movie) { FactoryBot.create(:movie) }
    let!(:active_show) { FactoryBot.create(:show, movie: movie, date: Date.today) }
    let!(:stale_show) { FactoryBot.create(:show, movie: movie, date: Date.yesterday) }

    it 'returns list of all upcoming shows for a movie' do
      get :upcoming_shows, params: { id: movie.id }
      upcoming_shows = JSON.parse(response.body)

      expect(upcoming_shows.count).to eq(1)
      expect(upcoming_shows.first['id']).to eq(active_show.id)
    end
  end
end
