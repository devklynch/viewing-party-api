require "rails_helper"

RSpec.describe "Users API", type: :request do

  describe "Create User Endpoint" do
    let(:user_params) do
      {
        name: "Me",
        username: "its_me",
        password: "QWERTY123",
        password_confirmation: "QWERTY123"
      }
    end

    context "request is valid" do
      it "returns 201 Created and provides expected fields" do
        post api_v1_users_path, params: user_params, as: :json

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data][:type]).to eq("user")
        expect(json[:data][:id]).to eq(User.last.id.to_s)
        expect(json[:data][:attributes][:name]).to eq(user_params[:name])
        expect(json[:data][:attributes][:username]).to eq(user_params[:username])
        expect(json[:data][:attributes]).to have_key(:api_key)
        expect(json[:data][:attributes]).to_not have_key(:password)
        expect(json[:data][:attributes]).to_not have_key(:password_confirmation)
      end
    end

    context "request is invalid" do
      it "returns an error for non-unique username" do
        User.create!(name: "me", username: "its_me", password: "abc123")

        post api_v1_users_path, params: user_params, as: :json
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:bad_request)
        expect(json[:message]).to eq("Username has already been taken")
        expect(json[:status]).to eq(400)
      end

      it "returns an error when password does not match password confirmation" do
        user_params = {
          name: "me",
          username: "its_me",
          password: "QWERTY123",
          password_confirmation: "QWERT123"
        }

        post api_v1_users_path, params: user_params, as: :json
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:bad_request)
        expect(json[:message]).to eq("Password confirmation doesn't match Password")
        expect(json[:status]).to eq(400)
      end

      it "returns an error for missing field" do
        user_params[:username] = ""

        post api_v1_users_path, params: user_params, as: :json
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:bad_request)
        expect(json[:message]).to eq("Username can't be blank")
        expect(json[:status]).to eq(400)
      end
    end
  end

  describe "Get All Users Endpoint" do
    it "retrieves all users but does not share any sensitive data" do
      User.create!(name: "Tom", username: "myspace_creator", password: "test123")
      User.create!(name: "Oprah", username: "oprah", password: "abcqwerty")
      User.create!(name: "Beyonce", username: "sasha_fierce", password: "blueivy")

      get api_v1_users_path

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].count).to eq(3)
      expect(json[:data][0][:attributes]).to have_key(:name)
      expect(json[:data][0][:attributes]).to have_key(:username)
      expect(json[:data][0][:attributes]).to_not have_key(:password)
      expect(json[:data][0][:attributes]).to_not have_key(:password_digest)
      expect(json[:data][0][:attributes]).to_not have_key(:api_key)
    end
  end

  describe "User Details endpoint" do

    before :each do
      @user = create(:user)
      @user1 = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
  
      party_params = {
        name: "Movie Party",
        start_time: "2025-02-02 10:30:00",
        end_time: "2025-02-02 14:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
        invitees: [@user.id,@user2.id]
    }
    party_params2 = {
      name: "Game night and movie watch",
      start_time: "2025-02-04 10:30:00",
      end_time: "2025-02-04 14:30:00",
      movie_id: 98,
      movie_title: "Gladiator",
      invitees: [@user1.id,@user2.id]
  }
  
    post "/api/v1/viewing_parties/#{@user1.id}", params: party_params
    @party1= JSON.parse(response.body, symbolize_names:true)
  
    post "/api/v1/viewing_parties/#{@user.id}", params: party_params2
    @party2 =JSON.parse(response.body, symbolize_names:true)
  
  end
    it "retrieves user info for a specific user" do

    get "/api/v1/users/#{@user1.id}"

    json_response = JSON.parse(response.body, symbolize_names:true)
    user_attributes = json_response[:data][:attributes]
    #binding.pry
        expect(response).to be_successful
        expect(json_response).to have_key(:data)
        expect(json_response[:data][:id]).to eq(@user1.id)
        expect(json_response[:data][:type]).to eq("user")
        expect(user_attributes[:name]).to eq(@user1.name)
        expect(user_attributes[:username]).to eq(@user1.username)
        expect(user_attributes).to_not have_key(:password_digest)
        expect(user_attributes[:viewing_parties_hosted].count).to eq(1)
        expect(user_attributes[:viewing_parties_hosted][0][:id]).to eq(@party1[:data][:id])
        expect(user_attributes[:viewing_parties_invited].count).to eq(1)
        expect(user_attributes[:viewing_parties_invited][0][:id]).to eq(@party2[:data][:id])
    end

    it "returns an empty array if there are no parties" do
      #binding.pry
      get "/api/v1/users/#{@user3.id}"
      json_response = JSON.parse(response.body, symbolize_names:true)
      user_attributes = json_response[:data][:attributes]

      expect(response).to be_successful
      expect(user_attributes[:viewing_parties_hosted]).to eq([])
    end

    it "returns an error if that user_id doesn't exist" do
      get "/api/v1/users/2"

      json_response = JSON.parse(response.body, symbolize_names:true)
    
      expect(json_response[:errors]).to eq(["Couldn't find User with 'id'=2"])
    end
  end
end
