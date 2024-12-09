class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :username, :api_key

  def self.format_user_list(users)
    { data:
        users.map do |user|
          {
            id: user.id.to_s,
            type: "user",
            attributes: {
              name: user.name,
              username: user.username
            }
          }
        end
    }
  end

  def self.format_user_details(user)
    { data: {
      id: user.id,
      type: "user",
      attributes: {
        name: user.name,
        username: user.username,
        viewing_parties_hosted: display_viewing_parties(user.viewing_parties.where(attendees: {is_host: true})),
        viewing_parties_invited: display_viewing_parties(user.viewing_parties.where(attendees: {is_host: false}))
      }
    }
  }
  end

  def self.display_viewing_parties(events)
    events.map do |event|
      {
        id: event.id,
        name: event.name,
        start_time: event.start_time,
        end_time: event.end_time,
        movie_id: event.movie_id,
        movie_title: event.movie_title,
        host_id: Attendee.where(viewing_party: event, is_host: true).pluck(:user_id).first
      }
    end
  end
end