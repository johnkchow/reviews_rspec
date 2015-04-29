module Api
  class SessionsController < ApplicationController
    respond_to :json

    def create
      if valid_credentials?
        sign_in user

        render json: {success: "ok"}
      else
        render json: {error: "bad auth"}, status: :bad_request
      end
    end

    protected

    def valid_credentials?
      user.try(:valid_password?, params[:password])
    end

    def user
      @user ||= User.find_by_email(params[:email])
    end
  end
end
