class Api::V1::ShowBlueprint < Blueprinter::Base
  identifier :id

  view :detail do
    fields :screen, :start_time, :end_time, :date, :is_full
  end
end