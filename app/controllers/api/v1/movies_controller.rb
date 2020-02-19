class Api::V1::MoviesController < Api::V1::BaseController
  load_resource except: [:index, :create, :edit]

  def index
  	movies = params[:is_admin] ? Movie.all : Movie.active_movies
    render json: (Api::V1::MovieBlueprint.render movies, view: :normal)
  end

  def upcoming_shows
    shows_list = Api::V1::ShowBlueprint.render @movie.shows.active_shows, view: :detail
    render json: shows_list
  end

  def create
    Movie.create(name: params[:name], rating: params[:rating])
    head :ok
  end

  def edit
    movie = Api::V1::MovieBlueprint.render Movie.find(params[:id]), view: :normal
    render json: movie
  end

  def update
    @movie.update(name: params[:name], rating: params[:rating], is_active: params[:is_active])
    head :ok
  end

  def destroy
    @movie.destroy
    head :ok
  end
end
