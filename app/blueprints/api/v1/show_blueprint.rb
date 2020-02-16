class Api::V1::ShowBlueprint < Blueprinter::Base
  identifier :id

  view :detail do
    fields :screen, :start_time, :end_time, :is_full
  end

  field :date do |show|
    show.date&.strftime(DATE_FORMAT)
  end
end