class Api::V1::ShowsController < ApplicationController
  load_resource

  def seats
    seats_list = Api::V1::SeatBlueprint.render @show.seats, view: :extended
    render json: seats_list
  end
end
