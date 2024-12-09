require "rails_helper"

RSpec.describe MovieGateway do
    describe "get movies by search" do
        it "calls TMDB with movie query and returns json response" do
            response_hash = MovieGateway.movie_search("Lord of the Rings")

            first_result = response_hash[:results][0]
            #binding.pry
            expect(response_hash).to be_a(Hash)
            expect(response_hash).to have_key(:results)
            expect(response_hash).to_not have_key(:errors)
            expect(response_hash[:results]).to be_an Array
            expect(first_result).to have_key(:title)
            expect(first_result).to have_key(:vote_average)
        end

        it "calls TMDB with top rated movie results" do
            response_hash = MovieGateway.top_rated
            first_result = response_hash[:results][0]

            expect(response_hash).to be_a(Hash)
            expect(response_hash).to have_key(:results)
            expect(response_hash).to_not have_key(:errors)
            expect(response_hash[:results]).to be_an Array
            expect(first_result).to have_key(:title)
            expect(first_result).to have_key(:vote_average)
        end
    end

    describe "movie details gateways" do
        it "calls TMDB to get movie_details" do
            response_hash = MovieGateway.movie_details(98)
            #binding.pry
            expect(response_hash).to be_a(Hash)
            expect(response_hash).to_not have_key(:errors)
            expect(response_hash).to have_key(:id)
            expect(response_hash).to have_key(:title)
            expect(response_hash).to have_key(:release_date)
            expect(response_hash).to have_key(:vote_average)
            expect(response_hash).to have_key(:runtime)
            expect(response_hash).to have_key(:genres)
            expect(response_hash[:genres]).to be_a(Array)
            expect(response_hash).to have_key(:overview)
        end
        
        it "calls TMDB to get movie_credits" do
            response_hash = MovieGateway.movie_credits(98)

            expect(response_hash).to be_a(Hash)
            expect(response_hash).to_not have_key(:errors)
            expect(response_hash).to have_key(:cast)
            expect(response_hash[:cast]).to be_a(Array)
        end

        it "calls TMDB to get movie_reviews" do
            response_hash = MovieGateway.movie_reviews(98)

            expect(response_hash).to be_a(Hash)
            expect(response_hash).to_not have_key(:errors)
            expect(response_hash).to have_key(:total_results)
            expect(response_hash).to have_key(:results)
            expect(response_hash[:results]).to be_a(Array)

        end
    end
end