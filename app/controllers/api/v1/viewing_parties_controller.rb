class Api::V1::ViewingPartiesController < ApplicationController

    def create
        host = User.find(params[:user_id])
        invitees = (params[:invitees])

        viewing_party = ViewingParty.create!(party_params)
        Attendee.create!(viewing_party: viewing_party, user: host, is_host: true)

        create_attendees(invitees,viewing_party)
        
        render json: ViewingPartySerializer.format_viewing_party(viewing_party)
    end

    def update
        viewing_party = ViewingParty.find(params[:id])
        new_invitees = params[:invitees_user_id]
      
        create_attendees(new_invitees,viewing_party)
   
        render json: ViewingPartySerializer.format_viewing_party(viewing_party)
    end

    private

    def party_params
        params.permit(:name, :start_time, :end_time, :movie_id, :movie_title)
    end

    def create_attendees(invitees,viewing_party)
        if invitees.is_a?(Integer)
            unless attendee_check(invitees,viewing_party)
            invitee = User.find(invitees)
            Attendee.create!(viewing_party: viewing_party, user: invitee, is_host: false)
            end
        else
            invitees.each do |invitee_id|
                unless attendee_check(invitee_id,viewing_party)
                invitee = User.find(invitee_id)
                Attendee.create!(viewing_party: viewing_party, user: invitee, is_host: false)
                end
            end
        end
    end

    def attendee_check(invitee_id,viewing_party)
        Attendee.exists?(viewing_party: viewing_party, user_id: invitee_id)
    end

end