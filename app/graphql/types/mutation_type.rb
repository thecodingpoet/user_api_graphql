module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser, description: "Creates a user"
    field :update_user, mutation: Mutations::UpdateUser, description: "Updates a user. Authentication Required"
    field :login_user, mutation: Mutations::LoginUser, description: "Login a user"
  end
end
