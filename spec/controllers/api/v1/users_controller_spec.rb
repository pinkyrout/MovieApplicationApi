require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'POST authenticate_user' do
    it 'returns success message if user with given email and password exists' do
      user = FactoryBot.create(:user)

      post :authenticate_user, params: { email: user.email, password: user.password_digest }
      res = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(res['message']).to eq('Success')
    end

    context 'when user enters invalid credentials' do
      it 'returns error message if user with given email does not exist' do
        user = FactoryBot.create(:user)
        invalid_email = 'mahon@gmail.com'

        post :authenticate_user, params: { email: invalid_email, password: user.password_digest }
        res = JSON.parse(response.body)

        expect(response.status).to eq(401)
        expect(res['message']).to eq('Login Fail')
      end

      it 'returns error message if user with given password does not exist' do
        user = FactoryBot.create(:user)
        invalid_password = 'movie'

        post :authenticate_user, params: { email: user.email, password: invalid_password }
        res = JSON.parse(response.body)

        expect(response.status).to eq(401)
        expect(res['message']).to eq('Login Fail')
      end
    end
  end
end