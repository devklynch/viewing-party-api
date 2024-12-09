require "rails_helper"

RSpec.describe ViewingParty, type: :model do
    describe "validations" do
        it { should validate_presence_of(:name)}
        it { should validate_presence_of(:start_time)}
        it { should validate_presence_of(:end_time)}
        it { should validate_presence_of(:movie_id)}
        it { should validate_presence_of(:movie_title)}
        it { should validate_presence_of(:name)}
        it {should have_many :attendees}
        it {should have_many(:users).through(:attendees)}
    end

    describe "party_run_time_check" do
        it "returns an error if the party length is shorter than the movie" do
            viewing_party = ViewingParty.create(
                name: "Movie Watch Party",
                start_time: "2025-02-03 01:30:00",
                end_time: "2025-02-03 01:40:00",
                movie_id: 278,
                movie_title: "The Shawshank Redemption" )
      
            expect(viewing_party.valid?).to eq(false)
            expect(viewing_party.errors[:base]).to eq(["Event cannot be shorter than the movie"])
        end
    end

    describe "party_time_check" do
        it "returns an error if the even start time is after the end time" do
            viewing_party = ViewingParty.create(
                name: "Movie Watch Party",
                start_time: "2025-02-05 01:30:00",
                end_time: "2025-02-03 01:40:00",
                movie_id: 278,
                movie_title: "The Shawshank Redemption")
            expect(viewing_party.valid?).to eq(false)
            expect(viewing_party.errors[:base]).to eq(["Event cannot be shorter than the movie", "End time cannot be before start time"])
        end
    end

    describe "time_check" do
        it "returns an error if the time given is not valid" do
            viewing_party = ViewingParty.create(
                name: "Movie Watch Party",
                start_time: "cat",
                end_time: "2025-02-03 01:40:00",
                movie_id: 278,
                movie_title: "The Shawshank Redemption")
          
            expect(viewing_party.valid?).to eq(false)
            expect(viewing_party.errors[:base]).to eq(["Start and End Time must be valid"])
        end
    end
end