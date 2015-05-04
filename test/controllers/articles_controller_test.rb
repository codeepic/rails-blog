require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  setup do
    @article = articles(:welcome_to_rails) # obtained from fixture
  end
  # the setup method is executed before every test case

  test "should get index" do
    get :index
    assert_response :success # could have also used 200
    assert_template 'index'
    assert_not_nil assigns(:articles)
    # the last line asserts that the correct instance variables were assigned.
    # If you look at the articles controller, you see that you set an instance variable
    # called @articles that contains the articles collection. Rails gives you the ability
    # to test whether this assignment was successful by way of the assigns method:
    # assert_not_nil assigns(:articles)
    # This asserts that @articles was, in fact, assigned (by virtue of the fact that
    # it shouldn’t be nil). You can use this technique to test for the existence
    # of any instance variable set within your controllers.
  end

  test "should get new" do
    login_as(:eugene) #login_as comes from test_helper.rb
    get :new
    assert_response :success
  end

  test "should create article" do
    login_as(:eugene)
    assert_difference('Article.count') do
      post :create, :article => { :title => 'Post title', :body => 'Lorem ipsum...' }
    end

    assert_response :redirect
    assert_redirected_to article_path(assigns(:article))
  end

  test "should show article" do
    get :show, :id => @article.to_param
    # @article.to_param by default gets the id attribute of the :welcome_to_rails article
    # you're getting from articles.yml fixture assigned to @article in
    # the setup method at the top of this file (setup method runs before each test)
    
    assert_response :success
    assert_template 'show'
    assert_not_nil assigns(:article)
    assert assigns(:article).valid?
  end

  test "should get edit" do
    login_as(:eugene)
    get :edit, :id => @article.to_param
    assert_response :success
  end

  test "should update article" do
    login_as(:eugene)
    put :update, :id => @article.to_param, :article => { :title => 'New title' }
    assert_redirected_to article_path(assigns(:article))
  end

  test "should destroy article" do
    login_as(:eugene)
    
    assert_nothing_raised { Article.find(@article.to_param) }

    assert_difference('Article.count', -1) do
      delete :destroy, :id => @article.to_param
    end    

    assert_response :redirect
    assert_redirected_to articles_path
    
    assert_raise(ActiveRecord::RecordNotFound){ Article.find(@article.to_param) }

  end
end
