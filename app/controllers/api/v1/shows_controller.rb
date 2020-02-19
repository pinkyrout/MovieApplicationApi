class Api::V1::ShowsController < ApplicationController
  load_resource except: :index

  def index
    render json: (Api::V1::ShowBlueprint.render Show.includes(:movie), view: :extended)
  end

  def seats
    seats = @show.seats.order(id: :desc)
    count = seats.count
    seats = seats.page(params[:page] || 1).per(10) if params[:is_admin]
    data = { seats: (Api::V1::SeatBlueprint.render seats, view: :extended), count: count }
    render json: data
  end
end
