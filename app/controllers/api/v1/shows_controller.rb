class Api::V1::ShowsController < ApplicationController
  load_resource except: :index

  def index
    render json: (Api::V1::ShowBlueprint.render Show.includes(:movie), view: :extended)
  end

  def seats
    seats_list = Api::V1::SeatBlueprint.render @show.seats, view: :extended
    render json: seats_list
  end
end
