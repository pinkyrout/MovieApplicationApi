class Api::V1::MoviesController < Api::V1::BaseController
  load_resource except: [:index, :create, :edit]

  def index
    movies = params[:is_admin] ? Movie.all : Movie.active_movies
    render json: (Api::V1::MovieBlueprint.render movies.order(id: :desc), view: :normal)
  end

  def upcoming_shows
    shows_list = Api::V1::ShowBlueprint.render @movie.shows.active_shows, view: :extended
    render json: shows_list
  end

  def create
    movie = Movie.new(name: params[:name], rating: params[:rating], is_active: params[:is_active])
    if movie.save
      render_success(message: "Success", status: :ok)
    else
      render_error(message: "Creation Failed", status: :unprocessible_entity)
    end
  end

  def edit
    movie = Api::V1::MovieBlueprint.render Movie.find(params[:id]), view: :normal
    render json: movie
  end

  def update
    if @movie.update(name: params[:name], rating: params[:rating], is_active: params[:is_active])
      render_success(message: "Success", status: :ok)
    else
      render_error(message: "Update Failed", status: :unprocessible_entity)
    end
  end

  def destroy
    if @movie.destroy
      render_success(message: "Success", status: :ok)
    else
      render_error(message: "Delete Failed", status: :unprocessible_entity)
    end
  end
end
