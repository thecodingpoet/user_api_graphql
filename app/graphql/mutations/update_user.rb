class Mutations::UpdateUser < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :first_name, String, required: false
  argument :last_name, String, required: false
  argument :email, String, required: false
  argument :password, String, required: false
  argument :password_confirmation, String, required: false

  type Types::UserType

  def ready?(**args)
    if context[:current_user]&.id != args[:id].to_i
      raise GraphQL::ExecutionError, "Unauthorized!"
    else
      true
    end
  end

  def resolve(id:, **attributes)
    user = User.find(id)
    user.update!(attributes)
    user
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end
