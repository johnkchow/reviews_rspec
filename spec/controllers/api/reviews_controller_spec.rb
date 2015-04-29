require 'rails_helper'

RSpec.describe Api::ReviewsController, type: :controller do
  describe "#create" do

    context "when the user is not authenticated" do
      let(:params) { {} }
      it "should return a 401" do
        post :create, params
        expect(response.status).to eq(401)
      end
    end

    context "when user is authed and the params are valid" do
      let(:user) { FactoryGirl.create(:user) }
      let(:reviewee) { FactoryGirl.create(:user) }
      let(:params) { {review: review_params}  }
      let(:review_params) { {reviewee_id: reviewee.id, comment: "Great job!"} }
      let(:mock_service) { instance_double(CreateReviewService, valid?: true, perform: true) }

      before do
        sign_in user
        allow(CreateReviewService).to receive(:new).and_return(mock_service)
      end

      it "should return 200" do
        post :create, params
        expect(response.status).to eq(200)
      end

      it "should call the review service to perform" do
        expect(mock_service).to receive(:perform)
        post :create, params
      end
    end
  end

  describe "#index" do
    let(:user) { FactoryGirl.create(:user) }

    let!(:reviews) do
      3.times do
        FactoryGirl.create(:review, reviewee: user)
      end
    end

    before do
      sign_in user
    end

    it "should return the reviews" do
      get :index
      expect(response.status).to eq(200)

      data = JSON.parse(response.body).with_indifferent_access
      expect(data[:reviews].length).to eq(3)
    end
  end
end
