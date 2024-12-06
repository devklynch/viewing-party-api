class ViewingParty < ApplicationRecord
    has_many :attendees
    has_many :users, through: :attendees

    validates :name, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :movie_id, presence: true
    validates :movie_title, presence: true
end