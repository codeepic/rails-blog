ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as(user)
    @request.session[:user_id] = users(user).id # obtained from fixture
  end
  # The login_as method manually sets user_id in the @request.session object (just like your
  # login action does) to the id of the given user, as obtained from the fixture.
  # If you give it the name of one of your users
  # fixtures, say, :eugene, it sets session[:user_id] to users(:eugene).id.
end
