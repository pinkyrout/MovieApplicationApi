class Api::V1::ShowsController < Api::V1::BaseController
  load_resource except: :index

  def index
    render json: (Api::V1::ShowBlueprint.render Show.order(id: :desc).includes(:movie), view: :extended)
  end

  def seats
    seats = @show.seats.order(id: :desc)
    count = seats.count
    seats = seats.page(params[:page] || 1).per(10) if params[:is_admin]
    data = {
      seats: (Api::V1::SeatBlueprint.render seats, view: :extended),
      show: (Api::V1::ShowBlueprint.render @show, view: :extended),
      count: count
    }
    render json: data
  end

  def download_report
    file_path = V1::Export::ShowReport.new({id: params[:id]}).process
    if file_path
      render_success(data: { file_path: file_path }, message: 'Exported Successfully', status: :ok) if file_path
    else
      render_error(message: "Export Failed", status: :unprocessible_entity)
    end
  end
end
