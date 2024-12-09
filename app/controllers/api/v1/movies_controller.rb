class Api::V1::MoviesController < ApplicationController
    def index
        if params[:query].present?
            json = MovieGateway.movie_search(params[:query])
        else
            json = MovieGateway.top_rated
        end

        render json: MovieSerializer.format_movie_list(json[:results])
    end

    def show
        movie_id = (params[:id]).to_i
        movie_details_json = MovieGateway.movie_details(movie_id)
        movie_credits_json = MovieGateway.movie_credits(movie_id)
        movie_reviews_json = MovieGateway.movie_reviews(movie_id)

        movie_details_compiled = Movie.new(movie_details_json,movie_credits_json,movie_reviews_json)
        render json: MovieSerializer.format_movie_details(movie_details_compiled)
    end
end
