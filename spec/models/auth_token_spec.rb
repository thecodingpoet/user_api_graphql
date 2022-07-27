require 'rails_helper'

RSpec.describe AuthToken, type: :model do
  describe '#token' do
    it 'is successful' do 
      user = create(:user)

      token = AuthToken.token(user_id: user.id)

      expect(token).to be_kind_of(String)
      expect(token.split('.').length).to eq(3)
    end
  end

  describe "#verify" do
    it 'is successful' do
      user = create(:user)

      token = AuthToken.token(user_id: user.id)
      decoded_token = AuthToken.verify(token)

      expect(decoded_token[:user_id]).to eq(user.id)
    end
  end
end
