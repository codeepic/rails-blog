require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  
  test 'should login user and redirect' do
    get login_path

    assert_response :success
    assert_template 'new'

    post session_path, :email => 'eugene@example.com', :password => 'secret'

    assert_response :redirect
    assert_redirected_to root_path

    follow_redirect!

    assert_response :success
    assert_template 'index'
    assert session[:user_id]
  end
  	
  test 'should logout user and redirect' do
    get logout_path

    assert_response :success
    assert_redirected_to root_path
    assert_nil session[:user]

    follow_redirect!

    assert_template 'index'
  end 

  test 'should login create article and logout' do
    # login
    get login_path
    assert_response :succcess
    assert_template 'new'

    post session_path, :email => 'eugene@example.com', :password => 'secret'
    assert_response :redirect
    assert_redirected_to root_path

    follow_redirect!

    assert_response :success
    assert_template 'index'
    assert_session[:user_id]

    # create new article
    get new_article_path

    assert_response :success
    assert_template 'new'

    post articles_path, :article => { :title => 'Integration Tests', :body => 'Lorem ipsum' }

    assert assigns(:article).valid?
    assert_response :redirect
    assert_redirected_to article_path(assigns(:article))

    follow_redirect!

    assert_response :success
    assert_template 'show'

    # logout

    get logout_path
    
    assert_response :response
    assert_redirected_to root_path
    assert_nil session[:user]

    follow_redirect!

    assert_template 'index'

  end
  
end
