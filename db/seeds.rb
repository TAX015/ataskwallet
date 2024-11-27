# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.destroy_all
personal = User.create(email: 'developer@gmail.com', password: 'password', name: 'Developer', user_type: 'personal', is_admin: true)
team = User.create(email: 'team@gmail.com', password: 'password', name: 'Team', user_type: 'team', is_admin: false)
stock = User.create(email: 'stock@gmail.com', password: 'password', name: 'Stock', user_type: 'stock', is_admin: false)

Wallet.destroy_all
Wallet.create([{user_id: personal.id}, {user_id: team.id}, {user_id: stock.id}])
