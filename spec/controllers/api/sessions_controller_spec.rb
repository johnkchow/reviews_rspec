require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  describe "#create" do
    let(:user_params) { {} }
    let(:params) { {user: user_params, format: :json} }

    shared_examples "fail with 400" do
      it "should return a 400" do
        post :create, params
        expect(response.status).to eq(400)
      end
    end

    context "when the user params is valid" do
      let!(:user) { FactoryGirl.create(:user, password: "johnchow") }

      let(:user_params) { {email: user.email, password: "johnchow" } }

      it "should return 200" do
        post :create, params
        expect(response.status).to eq(200)
      end
    end

    context "when the user hasn't been created" do
      let!(:user_params) { {email: "notfound@gmail.com" } }

      it "should return a 404" do
        post :create, params
        expect(response.status).to eq(404)
      end
    end

    context "when the email is missing" do
      it_should_behave_like "fail with 400"
    end

    context "when the password is wrong" do
      it_should_behave_like "fail with 400"
    end
  end
end
