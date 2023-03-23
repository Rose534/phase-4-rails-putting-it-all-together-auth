class ApplicationController < ActionController::API
  include ActionController::Cookies
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid 
  before_action :authorize
  
  
  private

  def authorize
    @current_user = User.find_by(id: session[:user_id]) 
    render json: { errors: ["Not authorized"]}, status: 401 unless @current_user 
  end


 def handle_invalid(exception)
    render json: {errors: exception.record.errors.full_messages }, status: 422
  end

end
