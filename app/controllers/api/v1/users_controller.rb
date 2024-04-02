module Api
  module V1
    class UsersController < ApplicationController
      include AuthorizationHelper
      before_action :authorized, only: [:auto_login, :logout]

      def index
        users = User.all
        render json: users
      end

      def register
        user = User.create(user_params)
        return render json: { error: user.errors } unless user.valid?

        token = AuthorizationHelper.encode_token({ user_id: user.id })
        render json: { user:, token: }, status: :created
      end

      def login
        user = User.find_by(username: params[:username])
        if user.nil? || !user.authenticate(params[:password])
          return render json: { error: 'Invalid username or password' }
        end

        token = AuthorizationHelper.encode_token({ user_id: user.id })
        render json: { user:, token: }
      end

      def logout
        token = request.headers['Authorization']
        BlacklistedToken.create(token: token, expires_at: Time.now)
        reset_session
        render json: { message: 'Logged out successfully' }
      end

      def auto_login
        render json: user
      end

      private

      def user_params
        params.permit(:username, :email, :password)
      end
    end
  end
end
