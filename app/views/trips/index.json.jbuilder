  json.username current_user.username

json.trips(@trips) do |trip|

  json.id trip.id
  json.title trip.title
  json.destination trip.destination
  json.description trip.description
  json.start_date trip.start_date
  json.end_date trip.end_date
  json.trip_type trip.trip_type
  json.notes trip.notes

  json.comments(trip.comments) do |comment|

    # include comment fields
    json.id comment.id
    json.entry comment.entry
    json.commenter comment.commenter

  end
end
