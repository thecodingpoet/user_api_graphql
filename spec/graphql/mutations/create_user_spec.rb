require 'rails_helper'

RSpec.describe Mutations::CreateUser, type: :graphql do
  describe '.resolve' do 
    it 'is successful' do
      user = build(:user)

      result = perform(
        email: user.email, 
        password: user.password, 
        password_confirmation: user.password,
        first_name: user.first_name, 
        last_name: user.last_name,
      )

      expect(result[:user]).to be_persisted
      expect(result[:token]).to be_present
    end

    it 'fails' do
      user = build(:user)

      result = perform(
        email: "INVALID", 
        password: user.password, 
        password_confirmation: user.password,
        first_name: user.first_name, 
        last_name: user.last_name,
      )

      expect(result).to be_an_instance_of(GraphQL::ExecutionError)
    end
  end

  def perform(user: nil, **args)
    Mutations::CreateUser.new(object: nil, field: nil, context: {}).resolve(**args)
  end
end
