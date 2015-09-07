# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

venue_pages = [
  "www.facebook.com/sunset411",
  "www.facebook.com/Club12.Erevan?ref=br_rs",
  "www.facebook.com/MozartKaraokeClub?ref=br_rs",
  "www.facebook.com/PaparazziclubYerevan?ref=br_rs",
  "www.facebook.com/london.bar.armenia?ref=br_rs",
  "www.facebook.com/newbaryerevan?ref=br_rs",
  "www.facebook.com/pages/Wave-karaoke-club/243752005795984?ref=br_rs",
  "www.facebook.com/OpiumClubYerevan?ref=br_rs",
  "www.facebook.com/pages/2794-Hin-Erivan/431298480259870?ref=br_rs",
  "www.facebook.com/pages/Traffic/303126063176407?ref=br_rs",
  "www.facebook.com/ARLYmusicclub?ref=br_rs",
  "www.facebook.com/WhiteCrowClub?ref=br_rs",
  "www.facebook.com/pages/MER-CLUB/275988509254106?ref=br_rs",
  "www.facebook.com/pages/Headbanger-Club/1395448670738996?ref=br_rs"
]

venue_pages.each do |venue_page|
  Venue.create(fb_page: venue_page, from_facebook: "true")
end