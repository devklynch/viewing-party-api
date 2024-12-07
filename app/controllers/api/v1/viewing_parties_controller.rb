class Api::V1::ViewingPartiesController < ApplicationController

    def create
        #the params will give an array of invitees ex [11,4,3]; we need to only add the invitees that exist, if they don't we just skip and there's no error
        host = User.find(params[:user_id])
        invitees = (params[:invitees]) #[2,3]
        viewing_party = ViewingParty.create!(party_params)
        #create host
        Attendee.create!(viewing_party: viewing_party, user: host, is_host: true)

        #create attendees none host
        invitees.each do |invitee_id|
            invitee = User.find(invitee_id)
            Attendee.create!(viewing_party: viewing_party, user: invitee, is_host: false)
        end
        render json: ViewingPartySerializer.format_viewing_party(viewing_party)
    end

    def update
        viewing_party = ViewingParty.find(params[:id])
        new_invitee = User.find(params[:invitees_user_id])

        Attendee.create!(viewing_party: viewing_party, user: new_invitee, is_host: false)

        render json: ViewingPartySerializer.format_viewing_party(viewing_party)
    end

    private

    def party_params
        params.permit(:name, :start_time, :end_time, :movie_id, :movie_title)
    end
end