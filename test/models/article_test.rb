require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
	test 'should create an article' do
    article = Article.new
    article.user = users(:eugene) # fixtures can be accessed in your test cases by name
                                  # use fixture(:name) where fixture is the plural name of the model
    article.title = 'test article'
    article.body = 'Test body'

    assert article.save
	end

	test 'should find article ' do
	  article_id = articles(:welcome_to_rails).id #accessing fixture
    assert_nothing_raised {Article.find(article_id)}
    # you use assert_nothing_raised because you know that find
    # raises an exception if the record can't be found
	end

	test 'should update article' do
    article = articles(:welcome_to_rails)
    assert article.update_attributes(:title => 'New title')
	end
		
	test 'should destroy article' do
    article = articles(:welcome_to_rails)
    
    assert article.destroy 
    # article.destroy
    # assert_raise(ActiveRecord::RecordNotFound) {Articles.find(article.id)}
	end

	test 'should not create an article without title nor body' do
    article = Article.new

    assert !article.valid?
    assert article.errors[:title].any?
    assert article.errors[:body].any?
    assert_equal ["can't be blank"], article.errors[:title]
    assert_equal ["can't be blank"], article.errors[:body]
    assert !article.save
	end
  # test "the truth" do
  #   assert true
  # end
end
