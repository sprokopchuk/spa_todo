class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::MimeResponds
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  rescue_from CanCan::AccessDenied do |exception|
    render json: {error: exception.message}, status: :forbidden
  end
end
