class Api::V1::MoviesController < ApplicationController
    def index

        if params[:query].present?
            json = MovieGateway.movie_search(params[:query])
        
        else
            json = MovieGateway.top_rated
        end

        render json: MovieSerializer.format_movie_list(json[:results])
    end
end
