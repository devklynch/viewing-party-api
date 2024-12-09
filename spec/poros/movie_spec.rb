require "rails_helper"

RSpec.describe Movie do
    it "can extract data from json and populate attributes" do
        movie_details_json = File.read("spec/fixtures/movie_details.json")
        details_parse = JSON.parse(movie_details_json, symbolize_names: true)
        movie_credits_json = File.read("spec/fixtures/movie_credits.json")
        credits_parse = JSON.parse(movie_credits_json, symbolize_names: true)
        movie_reviews_json = File.read("spec/fixtures/movie_reviews.json")
        reviews_parse = JSON.parse(movie_reviews_json, symbolize_names: true)
       
        movie_info = Movie.new(details_parse,credits_parse,reviews_parse)

        #binding.pry
        expect(movie_info.id).to eq("98")
        expect(movie_info.title).to eq("Gladiator")
        expect(movie_info.release_year).to eq(2000)
        expect(movie_info.vote_average).to eq(8.216)
        expect(movie_info.runtime).to eq("2 hours, 35 minutes")
        expect(movie_info.genres).to eq(["Action", "Drama", "Adventure"])
        expect(movie_info.summary).to include("After the death of Emperor Marcus Aurelius")
        expect(movie_info.cast[0][:actor]).to eq("Russell Crowe")
        expect(movie_info.total_reviews).to eq(5)
        expect(movie_info.reviews[0][:author]).to eq("Eky")
    end
end