require 'rails_helper'
describe User, type: :model do
  
  context 'validations' do
    it{ should validate_presence_of(:username) }
    it{ should validate_uniqueness_of(:username) }
    it{ validate_length_of(:username).is_at_least(User::MIN_USERNAME_LENGTH) }
    it{ should validate_presence_of(:email) }
    it{ should validate_uniqueness_of(:email) }
  end
end
