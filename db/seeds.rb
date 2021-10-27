# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(email: 'admin@brentmark.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "admin", last_name: "admin", role: User::ADMIN, confirmed_at: Time.now.utc).skip_confirmation!

# User.create!(email: 'fatiq1@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'test2@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'fatiq3@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'test4@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'fatiq5@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'test6@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'fatiq7@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'test8@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'fatiq9@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'test10@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'fatiq11@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'test12@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'fatiq13@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'test14@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'fatiq15@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'test16@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'fatiq17@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
# User.create!(email: 'test18@gmail.com',password: 'Password123!@#', password_confirmation: 'Password123!@#', first_name: "Khan", last_name: "user", role: User::USER, confirmed_at: Time.now.utc).skip_confirmation!
