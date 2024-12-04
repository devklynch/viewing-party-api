class Api::V1::MoviesController < ApplicationController
    def index
        conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
            faraday.headers['Authorization']= "Bearer #{Rails.application.credentials.tmdb[:token]}"
             end

        if params[:query].present?

            response = conn.get("/3/search/movie?query=#{params[:query]}")
        
        else
        response = conn.get("/3/movie/top_rated")
        end
        json = JSON.parse(response.body, symbolize_names: true)
    
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
        
        render json: {data: full_data}
    end
end
