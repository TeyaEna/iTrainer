require 'spec_helper'

describe UsersAdditionalController do
  let(:valid_user_params) { FactoryGirl.attributes_for(:user) }
  let(:valid_workout_preference_params) { FactoryGirl.attributes_for(:workout_preference) }

  before do
    @user = User.create!(valid_user_params)
    sign_in(:user, @user)
  end

  describe "GET #edit" do
    it "shows the edit page with the correct params are passed in" do
      get :edit, id: @user.id
      response.should be_ok
    end

    context "when a user does not exist" do
      it "raises a 404 status code" do
        get :edit, id: 5000
        response.status.should be(404)
      end

      it "renders a 404 page" do
        get :edit, id: 5000
        response.should render_template(file: "#{Rails.root}/public/404.html")
      end
    end

    context "when a user tries to access an edit page which doesn't belong to them" do
      before do
        @user_two = FactoryGirl.create(:user)
        sign_in(:user, @user_two)
      end
      it "redirects the user to a 404 a page" do
        get :edit, id: @user.id
        response.status.should be(404)
      end
    end
  end

  describe "PUT #update" do
    before do
      workout_preference_params = valid_workout_preference_params.merge(user_id: @user.id)
      @user_params = valid_user_params.merge(workout_preferences: workout_preference_params)
    end
    it "updates the user record" do
      put :update, { id: @user.id, user: @user_params }
      assigns(:user).should eq @user
    end

    it "adds a new record for the workout prefernce" do
      expect{
        put :update, { id: @user.id, user: @user_params }
      }.to change(WorkoutPreference, :count ).by(1)
    end

    it "renders the edit page when the params are missing" do
      put :update, { id: @user.id, user: { about_me: "" } }
      response.should render_template("edit")
    end
  end
end