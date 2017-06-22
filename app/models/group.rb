class Group < ActiveRecord::Base
  groupify :group, members: [:users, :reports], default_members: :users

  has_and_belongs_to_many :users, join_table: "groups_users"
  has_many :reports, join_table: "groups_reports"
  validates :title, presence: true, length: {maximum: 140}
  validates :description, presence: true
  validates :group_code, presence: true

end
