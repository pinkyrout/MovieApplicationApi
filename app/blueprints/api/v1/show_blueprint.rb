class Api::V1::ShowBlueprint < Blueprinter::Base
  identifier :id

  view :extended do
    fields :screen, :start_time, :end_time, :is_full
  end

  field :date do |show|
    show.date&.strftime(DATE_FORMAT)
  end

  field :movie_name do |show|
    show.movie&.name
  end
end