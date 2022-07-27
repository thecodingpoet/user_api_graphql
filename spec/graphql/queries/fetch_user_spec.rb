require 'rails_helper'

RSpec.describe Queries::FetchUser, type: :graphql do
  describe '.ready?' do 
    it 'is successful' do
      user = create(:user)

      result = ready?(user: user, id: user.id, email: "new_email@hey.com")

      expect(result).to eq(true)
    end 

    it 'raises an error' do
      user = create(:user)

      expect {
        ready?(id: user.id, email: "new_email@hey.com")
      }.to raise_error(GraphQL::ExecutionError, "Authentication Required!")
    end
  end

  describe '.resolve' do 
    it 'is successful' do
      user = create(:user)

      result = perform(user: user, id: user.id)

      expect(result.id).to eq(user.id)
      expect(result.email).to eq(user.email)
      expect(result.first_name).to eq(user.first_name)
      expect(result.last_name).to eq(user.last_name)
    end

    it 'fails' do 
      user = create(:user)

      result = perform(user: user, id: 'INVALID')

      expect(result).to be_an_instance_of(GraphQL::ExecutionError)
      expect(result.message).to eq('User does not exist.')
    end
  end

  def perform(user: nil, **args)
    Queries::FetchUser.new(object: nil, field: nil, context: {current_user: user}).resolve(**args)
  end

  def ready?(user: nil, **args)
    Queries::FetchUser.new(object: nil, field: nil, context: {current_user: user}).ready?(**args)
  end 
end
