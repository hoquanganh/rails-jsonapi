# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

Article.delete_all
Author.delete_all

10.times {
  Author.create(name: Faker::Book.unique.author)
}

50.times {
  Article.create({
    title: Faker::Book.title,
    body: Faker::Lorem.paragraphs(number: rand(5..7)),
    author: Author.limit(1).order("RANDOM()").first # sql random
  })
}

10.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end

5.times do
  Stock.create(
    company_name: Faker::Company.name,
    symbol: Faker::Lorem.characters(number: 1),
    price: rand(100)
  )
end

5.times do |i|
  Team.create(
    name: "Team #{i + 1}",
    description: Faker::Lorem.characters(number: 10)
  )
end

5.times do |i|
  Wallet.create(walletable: User.find(i + 1), balance: i * 200, currency: 'dolar')
end
