require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :controller do
  describe 'GET index' do
    let!(:active_movie) { FactoryBot.create(:movie, is_active: true) }
    let!(:inactive_movie) { FactoryBot.create(:movie, is_active: false) }

    context 'when params have is_admin flag' do
      it 'returns list of all movies in descending order of id' do
        get :index, params: { is_admin: true }
        movies = JSON.parse(response.body)

        expect(movies.count).to eq(2)
        expect(movies.pluck('id')).to eq([inactive_movie.id, active_movie.id])
      end
    end

    context 'when params do not have is_admin flag' do
      it 'returns list of active movies only' do
        get :index
        movies = JSON.parse(response.body)

        expect(movies.count).to eq(1)
        expect(movies.pluck('id')).to eq([active_movie.id])
      end
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

  describe 'POST create' do
    it 'creates new movie record and renders success message if saved successfully' do
      expect(Movie.count).to eq(0)

      post :create, params: { name: 'Dangal', rating: 9.0, is_active: true }
      res = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(res['message']).to eq("Success")
      expect(Movie.count).to eq(1)
    end
  end

  describe 'GET edit' do
    let!(:movie) { FactoryBot.create(:movie) }

    it 'returns the movie whose id is sent in params' do
      get :edit, params: { id: movie.id }
      movie_data = JSON.parse(response.body)

      expect(movie_data['id']).to eq(movie.id)
    end
  end

  describe 'PATCH update' do
    let!(:movie) { FactoryBot.create(:movie, is_active: false, rating: 10.0, name: 'Dangal') }

    it 'updates the movie record with the passed params and returns success message' do
      new_name = 'Dangal1'
      new_rating = 9.0

      patch :update, params: { id: movie.id, name: new_name, rating: new_rating, is_active: true }
      res = JSON.parse(response.body)

      movie.reload
      expect(response.status).to eq(200)
      expect(res['message']).to eq("Success")
      expect(movie.name).to eq(new_name)
      expect(movie.rating).to eq(new_rating)
      expect(movie.is_active).to eq(true)
    end
  end

  describe 'DELETE destroy' do
    let!(:movie) { FactoryBot.create(:movie) }

    it 'deletes the movie whose id is sent in params and returns success message' do
      expect(Movie.count).to eq(1)

      delete :destroy, params: { id: movie.id }
      res = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(res['message']).to eq("Success")
      expect(Movie.count).to eq(0)
    end
  end
end
