class ViewingParty < ApplicationRecord
    has_many :attendees
    has_many :users, through: :attendees

    validates :name, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :movie_id, presence: true
    validates :movie_title, presence: true
    validate :time_check
    validate :party_run_time_check
    validate :party_time_check

    private

    def party_run_time_check
        return if start_time.nil? || end_time.nil?
        movie_details = MovieGateway.movie_details(self[:movie_id])
        run_time = movie_details[:runtime]
        starting = (self[:start_time])
        ending= (self[:end_time])
        if ((ending-starting)/60) < run_time
            errors.add(:base, "Event cannot be shorter than the movie")
        end
    end

    def party_time_check
        return if start_time.nil? || end_time.nil?
        starting =(self[:start_time])
        ending= (self[:end_time])
        if (ending-starting).negative?
            errors.add(:base, "End time cannot be before start time")
        end
    end

    def time_check
        unless self[:start_time].is_a?(Time) && self[:end_time].is_a?(Time) || (!self[:start_time].nil? && !self[:end_time].nil?)
            errors.add(:base, "Start and End Time must be valid")
        end
    end
end