class Api::V1::MoviesController < ApplicationController
    def index
        conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
            faraday.headers['Authorization']= "Bearer #{Rails.application.credentials.tmdb[:token]}"
        end

        response = conn.get("/3/movie/top_rated")

        # response = conn.get("/3/movie/top_rated", {api_key: Rails.application.credentials.tmdb[:key]})
        
        json = JSON.parse(response.body, symbolize_names: true)
        #require 'pry';binding.pry
        full_data = json[:results].map do |movie|
            {
            "id": (movie[:id]).to_s,
            "type": "movie",
            "attributes": {
                "title": movie[:title],
                "vote_average": movie[:vote_average]
            }
            }
        end
        #require 'pry';binding.pry
        render json: {data: full_data}
    end
end
