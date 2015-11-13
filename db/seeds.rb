# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

new_user = User.create(username: "donghwa", password: "password", email: "donghwa@ga.com", full_name: "Donghwa Lee", user_marker: "/lib/images/marker_dhl.png")

new_user2 = User.create(username: "andrew", password: "password", email: "andrew@ga.com", full_name: "Andrew Freeman", user_marker: "/lib/images/marker_andrew.png")

new_user3 = User.create(username: "john", password: "password", email: "john@ga.com", full_name: "John Kim", user_marker: "/lib/images/marker_john.png")

new_user4 = User.create(username: "tendai", password: "password", email: "tendai@ga.com", full_name: "Tendai Chiriga", user_marker: "/lib/images/marker_tendai.png")
