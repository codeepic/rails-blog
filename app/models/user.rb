require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password

  validates_uniqueness_of :email
  validates_length_of :email, :within => 5..50
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\Z/i, :on => :create
  #validates_format_of :email, :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i  

  validates_confirmation_of :password
  validates_length_of :password, :within => 4..20
  validates_presence_of :password, :if => :password_required?

  has_one :profile
  has_many :articles, -> { order('published_at DESC, title ASC')}, :dependent => :nullify
  has_many :replies, :through => :articles, :source => :comments

  before_save :encrypt_new_password

  def self.authenticate(email, password)
    user = find_by_email(email)
    return user if user && user.authenticated?(password)
  end

  def authenticated?(password)
    self.hashed_password == encrypt(password)
  end

  protected
    def encrypt_new_password
      return if password.blank?
      self.hashed_password = encrypt(password)
    end

    def password_required?
      hashed_password.blank? || password.present?
    end

    def encrypt(string)
      Digest::SHA1.hexdigest(string)
    end
end

# The SHA1 hashing algorithm used in this example is weak 
# and was only used for an example. For production web sites
# you should take a look at the bcrypt gem
# (https://github.com/codahale/bcrypt-ruby).




#orig
# class User < ActiveRecord::Base
#   validates_uniqueness_of :email
#   validates_length_of :email, :within => 5..50
#   validates_forat_of :email, :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i  

#   has_one :profile
#   has_many :articles, -> { order('published_at DESC, title ASC')}, :dependent => :nullify
#   has_many :replies, :through => :articles, :source => :comments
# end
