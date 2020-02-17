# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

movies_detail = [
  {name: 'Luve Aaj Kal', rating: 8.5},
  {name: 'Hacked', rating: 7.5}
]

shows_detail = [
  {start_time: 1200, end_time: 1500},
  {start_time: 1600, end_time: 1900},
  {start_time: 2000, end_time: 2300}
]

seats_detail = [{category: 'lower', price: 150.0, number: 30},
  {category: 'middle', price: 200.0, number: 40},
  {category: 'upper', price: 300.0, number: 30}
]

movies_detail.each do |movie_details|
  movie = Movie.find_or_create_by(name: movie_details[:name], rating: movie_details[:rating])
  shows_detail.each do |show_details|
    show = Show.find_or_create_by(start_time: show_details[:start_time], end_time: show_details[:end_time], date: Date.today, is_full: false, movie_id: movie.id)
    seats_detail.each do |seat_details|
      seat_details[:number].times do |index|
        Seat.find_or_create_by(category: seat_details[:category], price: seat_details[:price], is_booked: false, show_id: show.id, number: "#{seat_details[:category]}#{index+1}")
      end
    end
  end
end

User.find_or_create_by(username: 'Mohan', email: 'mohan@gmail.com')
