class MovieGateway
    def self.conn
        conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
            faraday.headers['Authorization']= "Bearer #{Rails.application.credentials.tmdb[:token]}"
        end
    end

    def self.movie_search(query)
        response = conn.get("/3/search/movie?query=#{query}")

        JSON.parse(response.body, symbolize_names: true)
    end

    def self.top_rated
        response = conn.get("/3/movie/top_rated")
        JSON.parse(response.body, symbolize_names: true)
    end
end