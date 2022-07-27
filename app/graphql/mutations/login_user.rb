module Mutations
  class LoginUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    type Types::AuthType

    def resolve(email:, password:)
      user = User.find_by_email(email)

      return unless user
      return unless user.authenticate(password)

      { user: user, token: AuthToken.token(user_id: user.id) }
    end
  end
end
