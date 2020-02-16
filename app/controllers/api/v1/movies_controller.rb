class Api::V1::MoviesController < Api::V1::BaseController
  load_resource

  def index
    movies = Api::V1::MovieBlueprint.render Movie.all, view: :normal
    render json: movies
  end

  def upcoming_shows
    shows_list = Api::V1::ShowBlueprint.render @movie.shows.active_shows, view: :detail
    render json: shows_list
  end
end
