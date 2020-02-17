require 'rails_helper'
describe Movie, type: :model do
  
  context 'validations' do
    it{ should validate_presence_of(:name) }
  end
end
