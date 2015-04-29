module Api
  class UsersController < ApplicationController
    respond_to :json

    def create
      if user = User.find_by_email(user_params[:email])
        render json: {error: "account exists"}, status: :conflict
        return
      end

      user = User.new(email: user_params[:email], password: user_params[:password])

      if user.save
        render json: {success: "account created"}
      else
        render json: {errors: user.errors.full_messages}, status: :bad_request
      end
    end

    protected

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
