class ApplicationController < ActionController::API
  include ::ActionController::Cookies

  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    jwt = cookies.signed[:jwt]
    @current_user = AuthorizeApiRequest.call(jwt).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def owner?(thing)
    @current_user == thing.user
  end

  def exists_and_owner?(thing)
    if thing && owner?(thing)
      true
    elsif thing
      render json: { error: "Not Authorized"}, status: 403
      return false
    else
      render json: { error: "Not Found"}, status: 404
      return false
    end
  end

end
