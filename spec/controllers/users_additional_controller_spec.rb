require 'spec_helper'

describe UsersAdditionalController do
  let(:valid_user_params) { FactoryGirl.attributes_for(:user) }
  let(:valid_workout_preference_params) { FactoryGirl.attributes_for(:workout_preference) }

  before do
    @user = User.create!(valid_user_params)
  end

  describe "GET #edit" do
    it "shows the edit page with the correct params" do
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

    it "renders edit page when the params are incorrect" do
      put :update, { id: @user.id, user: {} }
      response.should render_template("edit")
    end
  end
end