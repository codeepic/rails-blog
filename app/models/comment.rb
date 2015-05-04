class Comment < ActiveRecord::Base
  belongs_to :article

  validates_presence_of :name, :email, :body
  validate :article_should_be_published

  def article_should_be_published
    # errors.add(:article_id, 'is not published yet') if article && !article.published?
    errors.add(:article_id, I18n.t('comments.errors.not_published_yet')) if article && !article.published?
  end

  after_create :email_article_author
  after_create :send_comment_email

  def email_article_author
    puts "we will notify #{article.user.email} in chapter 9"
  end

  def send_comment_email
    Notifier.comment_added(self).deliver
  end
end
