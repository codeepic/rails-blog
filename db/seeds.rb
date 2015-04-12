# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


article = Article.create :title => 'absolutely new seeded', :body => 'some text body goes here', :published_at => Date.new
user = User.create :email => 'mary@example.com', :password => 'guessit'
Category.create [{:name => 'Programming'},
{:name => 'Event'},
{:name => 'Travel'},
{:name => 'Music'},
{:name => 'TV'}]
