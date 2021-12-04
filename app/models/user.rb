# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  articles_count  :integer
#  email           :string
#  folders_count   :integer
#  password_digest :string
#  phone           :string
#  private         :boolean
#  summaries_count :integer
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  validates :username, :uniqueness => { :case_sensitive => false }
  has_secure_password

  has_many(:articles)

  has_many(:summaries)

end
