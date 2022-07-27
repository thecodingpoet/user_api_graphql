class Mutations::CreateUser < Mutations::BaseMutation
  argument :email, String, required: true
  argument :password, String, required: true
  argument :password_confirmation, String, required: true
  argument :first_name, String, required: false
  argument :last_name, String, required: false

  type Types::AuthType

  def resolve(first_name:, last_name:, email:, password:, password_confirmation:)
    user = User.create!(
      email: email,
      password: password,
      password_confirmation: password_confirmation,
      first_name: first_name,
      last_name: last_name,
    )
  
    { user: user, token: AuthToken.token(user_id: user.id) }
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end
