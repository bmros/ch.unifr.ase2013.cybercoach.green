class UserLink < ActiveRecord::Base
  has_many :api_tokens
  has_many :subscriptions
  #self.primary_key = 'username'



  attr_accessor :password
  # attr_accessible :nom, :email, :password, :password_confirmation

  validates :password, :presence     => true,
            :confirmation => true,
            :length       => { :within => 1..40 }

  before_save :encrypt_password

  def has_password?(password_soumis)
    encrypted_password == encrypt(password_soumis)
  end

  def self.authenticate(username, submitted_password)
    #user = find_by_email(email)
    userlink = find_by_username(username)
    return nil  if userlink.nil?
    return userlink if userlink.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    userlink = find_by_id(id)
    (userlink && userlink.salt == cookie_salt) ? userlink : nil
  end










  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end





end
