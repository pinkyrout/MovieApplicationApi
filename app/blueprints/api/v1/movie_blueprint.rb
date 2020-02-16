class Api::V1::MovieBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name, :rating
  end
end
