module Api
  class ReviewsController < ApplicationController
    respond_to :json

    before_filter :require_authentication!

    def index
      render json: { reviews: current_user.reviews }
    end

    def create
      service = CreateReviewService.new(current_user, review_params)

      if service.valid?
        service.perform
        render json: {success: 'ok'}
      else
        render json: {error: service.messages }
      end
    end

    protected

    def review_params
      params.require(:review).permit(:comment, :reviewee_id)
    end

    def require_authentication!
      unless current_user
        render json: {error: "need to auth"}, status: :unauthorized
      end
    end
  end
end
