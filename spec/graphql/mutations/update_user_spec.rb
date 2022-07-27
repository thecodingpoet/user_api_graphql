require 'rails_helper'

RSpec.describe Mutations::UpdateUser, type: :graphql do
  describe '.ready?' do 
    it 'is successful' do
      user = create(:user)

      result = ready?(user: user, id: user.id, email: "new_email@hey.com")

      expect(result).to eq(true)
    end 

    it 'raises an error when unauthenticated' do
      user = create(:user)

      expect {
        ready?(id: user.id, email: "new_email@hey.com")
      }.to raise_error(GraphQL::ExecutionError, "Unauthorized!")
    end

    it 'raises an error when unauthorized' do
      user_1 = create(:user)
      user_2 = create(:user)

      expect {
        ready?(user: user_1, id: user_2.id, email: "new_email@hey.com")
      }.to raise_error(GraphQL::ExecutionError, "Unauthorized!")
    end
  end

  describe '.resolve' do 
    it 'is successful' do
      user = create(:user)

      result = perform(user: user, id: user.id, email: "new_email@hey.com")

      expect(result.email).to eq("new_email@hey.com")
    end

    it 'fails' do
      user = create(:user)

      result = perform(user: user, id: user.id, email: "INVALID")
      
      expect(result).to be_an_instance_of(GraphQL::ExecutionError)
    end
  end

  def ready?(user: nil, **args)
    Mutations::UpdateUser.new(object: nil, field: nil, context: {current_user: user}).ready?(**args)
  end 

  def perform(user: nil, **args)
    Mutations::UpdateUser.new(object: nil, field: nil, context: {current_user: user}).resolve(**args)
  end
end
