module Queries
  class FetchUser < Queries::BaseQuery
    argument :id, ID, required: true
    
    type Types::UserType, null: false

    def ready?(**args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, "Unauthenticated!"
      else
        true
      end
    end

    def resolve(id:)
      User.find(id)
    rescue ActiveRecord::RecordNotFound => e
      GraphQL::ExecutionError.new('User does not exist.')
    end
  end
end
