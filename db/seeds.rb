# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
@user1=User.create!(name: "Danny DeVito", username: "danny_de_v4", password: "jerseyMikesRox7")
@user2=User.create!(name: "Dolly Parton", username: "dollyP4", password: "Jolene123")
@user3=User.create!(name: "Lionel Messi", username: "futbol_geek4", password: "test123")

party_params = {
    name: "Test 6",
    start_time: "2025-02-02 10:30:00",
    end_time: "2025-02-02 14:30:00",
    movie_id: 278,
    movie_title: "The Shawshank Redemption"
}

@viewing_party1= ViewingParty.create!(party_params)
@viewing_party2 = ViewingParty.create!(party_params)

Attendee.create!(viewing_party:@viewing_party1, user:@user3, is_host: true)
Attendee.create!(viewing_party:@viewing_party2, user:@user1, is_host: true)
Attendee.create!(viewing_party:@viewing_party1, user:@user2, is_host: false)
Attendee.create!(viewing_party:@viewing_party2, user:@user3, is_host: false)