class CreateReviewService
  attr_reader :reviewer, :reviewee, :review_params

  def initialize(reviewer, review_params)
    @reviewer = reviewer
    @review_params = review_params
  end

  def perform
    review.save
  end

  def valid?
    reviewee && review.valid?
  end

  def messages
    if reviewee
      review.error.full_messages
    else
      ["Reviewee does not exist"]
    end
  end

  protected

  def reviewee
    @reviewee ||= User.find_by_id(review_params[:reviewee_id])
  end

  def review
    @review ||= Review.new(
      reviewer_id: reviewer.id,
      reviewee_id: reviewee.id,
      comment: review_params[:comment]
    )
  end
end
