# jgjhfgjh
class ApplicationController < ActionController::API
  include AuthorizationHelper

  def verify_authenticated
    decoded_token = AuthorizationHelper.decoded_token(request.headers['Authorization'])
    return false if decoded_token.nil?

    token = request.headers['Authorization']
    return false if BlacklistedToken.exists?(token:)

    user_id = decoded_token[0]['user_id']
    @user = User.find_by_id(user_id)
    @user.present?
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless verify_authenticated
  end

  def current_user
    return @user if defined?(@user)
    return nil unless verify_authenticated

    @user
  end

  def check_admin
    return if current_user.admin?

    render json: { error: 'Only admins are allowed to do this action.' }, status: :forbidden
  end
end
