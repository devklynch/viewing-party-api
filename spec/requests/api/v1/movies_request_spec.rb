require "rails_helper"

RSpec.describe "Movies API" do
    describe "Top Rated Movies Endpoint" do
        it "returns top-rate movies" do
            VCR.use_cassette("top_rated_movies") do

                get "/api/v1/movies"

                json = JSON.parse(response.body, symbolize_names: true)
                #binding.pry
                first_result = json[:data][0]
                expect(response).to be_successful
                expect(json[:data].count).to eq(20)
                expect(first_result[:id]).to eq("278")
                expect(first_result[:type]).to eq("movie")
                expect(first_result[:attributes]).to have_key(:title)
                expect(first_result[:attributes][:title]).to eq("The Shawshank Redemption")
                expect(first_result[:attributes]).to have_key(:vote_average)
                expect(first_result[:attributes][:vote_average]).to eq(8.707)
            end
        end

        it "returns movies when searching" do
            VCR.use_cassette("movie_search_lotr") do
                get "/api/v1/movies?query=lord%20of%20the%20rings"
                json = JSON.parse(response.body, symbolize_names: true)
                #binding.pry

                expect(response).to be_successful
                first_result = json[:data][0]
                expect(response).to be_successful
                expect(json[:data].count).to eq(19)
                expect(first_result[:id]).to eq("120")
                expect(first_result[:type]).to eq("movie")
                expect(first_result[:attributes]).to have_key(:title)
                expect(first_result[:attributes][:title]).to eq("The Lord of the Rings: The Fellowship of the Ring")
                expect(first_result[:attributes]).to have_key(:vote_average)
                expect(first_result[:attributes][:vote_average]).to eq(8.415)
            end
        end
    end
end