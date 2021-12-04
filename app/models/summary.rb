# == Schema Information
#
# Table name: summaries
#
#  id         :integer          not null, primary key
#  body       :string
#  public     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :integer
#  user_id    :integer
#
class Summary < ApplicationRecord
  validates(:body, presence: true)
  validates(:user_id, presence: true)
  validates(:article_id, presence: true)

  belongs_to(:user, required: true, counter_cache: true)

  belongs_to(:article, required: true)

end
