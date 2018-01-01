class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  attr_encrypted :first_name
  attr_encrypted :last_name

  def username
    last_inital = last_name[0]
    "#{first_name} #{last_inital}."
  end
end
