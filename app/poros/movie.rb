class Movie
    attr_reader :id,
                :title,
                :vote_average

    def initialize(movie_json)
        movie_json[:results].map do |movie|
            @id = movie[:id]
            @title = movie[:title]
            @vote_average = movie[:vote_average]
        end
    end
end