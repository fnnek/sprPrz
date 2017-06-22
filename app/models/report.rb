class Report < ApplicationRecord
  belongs_to :user
  mount_uploader :attachment, AttachmentUploader
  validates :title, presence: true
  groupify :group_member
  groupify :named_group_member
end
