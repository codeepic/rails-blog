# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create :email => 'mary@example.com',
                   :password => 'guessit',
                   :password_confirmation => 'quessit'
Category.create [{:name => 'Programing'},
                 {:name => 'Event'},
                 {:name => 'Travel'},
                 {:name => 'Music'},
                 {:name => 'TV'}]

user.articles.create :title => 'Advanced Active Record', 
                     :body => 'Models need t orelate to each other...',
                     :published_at => Date.today
user.articles.create :title => 'one to many associations',
                     :body => 'one to many associations describe the pattern',
                     :published_at => Date.today
user.articles.create :title => 'Associations',
                     :body => 'active record makes working with assoc easy',
                     :published_at => Date.today

#was
# article = Article.create :title => 'absolutely new seeded', :body => 'some text body goes here', :published_at => Date.new
# user = User.create :email => 'mary@example.com', :password => 'guessit'
# Category.create [{:name => 'Programming'},
# {:name => 'Event'},
# {:name => 'Travel'},
# {:name => 'Music'},
# {:name => 'TV'}]
