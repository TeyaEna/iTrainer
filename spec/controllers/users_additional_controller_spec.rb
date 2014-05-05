require 'spec_helper'

describe UsersAdditionalController do
  let(:valid_user_params) { FactoryGirl.attributes_for(:user) }
  let(:valid_workout_preference_params) { FactoryGirl.attributes_for(:workout_preference) }

  before do
    @user = User.create!(valid_user_params)
  end

  describe "GET #edit" do
    before do
      workout_preference_params = valid_workout_preference_params.merge(user_id: @user.id)
      @user_params = valid_user_params.merge(workout_preference_attributes: workout_preference_params)
    end
    it "shows the edit page with the correct params" do
      get :edit, id: @user.id
      response.should be_ok
    end

    it "updates the user record" do
      put :update, { id: @user.id, user: @user_params }
      assigns(:user).should eq @user
    end

    it "adds a new record for workout prefernce" do
      expect{
        put :update, { id: @user.id, user: @user_params }
      }.to change(WorkoutPreference, :count ).by(1)
    end
  end
end