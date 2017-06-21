class User < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  groupify :group_member
  groupify :named_group_member
  #groupify :group_membership
  has_and_belongs_to_many :groups, join_table: "groups_users"

  attr_accessor :remember_token, :activation_token
  before_save :downcase_email
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@prz.edu.pl|stud.prz.edu.pl+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest,User.digest(remember_token))
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships WHERE  follower_id = :user_id"
    Message.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end


  def forget
    update_attribute(:remember_digest,nil)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end


  private

    def downcase_email
      self.email = email.downcase
    end

end
