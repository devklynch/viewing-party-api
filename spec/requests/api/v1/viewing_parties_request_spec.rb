require "rails_helper"

RSpec.describe "Viewing Party" do
    describe "Create Viewing Party Endpoint" do
        it "can create a new viewing party" do
            @user = create(:user)
            @user1 = create(:user)
            @user2 = create(:user)
            @user3= create(:user)
            
            party_params = {
                name: "Test 6",
                start_time: "2025-02-02 10:30:00",
                end_time: "2025-02-02 14:30:00",
               movie_id: 278,
                movie_title: "The Shawshank Redemption",
                invitees: [@user.id,@user2.id]
            }

          post "/api/v1/viewing_parties/#{@user1.id}", params: party_params

            json_response = JSON.parse(response.body, symbolize_names: true)
            #binding.pry
            expect(response).to be_successful
            expect(json_response).to be_a(Hash)
            expect(json_response).to have_key(:data)
            expect(json_response[:data]).to have_key(:id)
            expect(json_response[:data]).to have_key(:type)
            expect(json_response[:data]).to have_key(:attributes)
            expect(json_response[:data][:attributes]).to have_key(:name)
            expect(json_response[:data][:attributes]).to have_key(:start_time)
            expect(json_response[:data][:attributes]).to have_key(:end_time)
            expect(json_response[:data][:attributes][:name]).to eq(party_params[:name])
            # expect(json_response[:data][:attributes][:start_time]).to eq(party_params[:start_time])
            # expect(json_response[:data][:attributes][:end_time]).to eq(party_params[:end_time])
            expect(json_response[:data][:attributes][:movie_id]).to eq(party_params[:movie_id])
            expect(json_response[:data][:attributes][:movie_title]).to eq(party_params[:movie_title])
            expect(json_response[:data][:attributes][:attendees][0][:id]).to eq(@user1.id)
            expect(json_response[:data][:attributes][:attendees][1][:id]).to eq(@user.id)
            expect(json_response[:data][:attributes][:attendees][2][:id]).to eq(@user2.id)


        end
    end
end