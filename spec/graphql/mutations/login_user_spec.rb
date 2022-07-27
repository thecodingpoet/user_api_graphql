require 'rails_helper'

RSpec.describe Mutations::LoginUser, type: :graphql do
  describe '.resolve' do 
    it 'is successful' do
      user = create(:user)

      result = perform(email: user.email, password: user.password)

      expect(result[:user]).to be_present
      expect(result[:token]).to be_present
      expect(result[:user][:id]).to eq(user.id)
    end

    it 'fails' do
      user = create(:user)

      result = perform(email: user.email, password: "INVALID")

      expect(result).to be_nil
    end
  end

  def perform(user: nil, **args)
    Mutations::LoginUser.new(object: nil, field: nil, context: {}).resolve(**args)
  end
end
