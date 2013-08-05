class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
          :rememberable, :trackable, :validatable
  			#:recoverable, (must add mailer info to application.rb for forgot pass page to work on heroku)
 

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body

  has_many :pics, :dependent => :destroy
end
