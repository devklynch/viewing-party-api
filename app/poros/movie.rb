class Movie
    attr_reader :id,
                :title,
                :release_year,
                :vote_average,
                :runtime,
                :genres,
                :summary,
                :cast,
                :total_reviews,
                :reviews

    def initialize(details,credits,reviews)
            #binding.pry
            @id = details[:id].to_s
            @title = details[:title]
            @release_year = details[:release_date][0..3].to_i
            @vote_average = details[:vote_average]
            @runtime = get_runtime(details[:runtime])
            @genres = details[:genres].map do |genre|
                genre[:name]
            end
            @summary = details[:overview]
            @cast = get_cast(credits[:cast])
            @total_reviews = reviews[:total_results]
            @reviews = get_reviews(reviews[:results])
        
    end

    def get_cast(cast)
        cast_list = cast[0..9]
        cast_list.map do |member|
            {
            character: member[:character],
            actor: member[:name]
        }
        end
    end

    def get_reviews(reviews)
        review_list = reviews[0..4]
        review_list.map do |review|
            {
            author: review[:author],
            review: review[:content]
        }
        end

    end

    def get_runtime(minutes)
        hours = minutes/60
        minutes = minutes%60
        "#{hours} hours, #{minutes} minutes"
    end

end