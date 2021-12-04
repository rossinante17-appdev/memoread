# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  email       :boolean
#  headline    :string
#  public      :boolean
#  read        :boolean
#  read_at     :datetime
#  reread_list :boolean
#  text        :boolean
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  source_id   :integer
#  summary_id  :integer
#  user_id     :integer
#
class Article < ApplicationRecord

  validates :url, presence: true
  validates :url, :uniqueness => { :case_sensitive => false }

  belongs_to(:user, counter_cache: true)

  belongs_to(:summary)

end
