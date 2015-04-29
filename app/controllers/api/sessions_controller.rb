module Api
  class SessionsController < ApplicationController
    respond_to :json

    def create
      if !user
        render json: {error: "not found"}, status: :not_found
      elsif valid_credentials?
        sign_in(user)

        render json: {success: "ok"}
      else
        render json: {error: "bad auth"}, status: :bad_request
      end
    end

    rescue_from ActionController::ParameterMissing do |e|
      respond_to do |format|
        format.json { render json: {error: e.message}, status: :bad_request }
        format.any { raise e }
      end
    end

    protected

    def valid_credentials?
      user.try(:valid_password?, user_params[:password])
    end

    def user
      @user ||= User.find_by_email(user_params[:email])
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
