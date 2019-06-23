class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :costs, dependent: :destroy

  attr_accessor :demand_token, :demand_mail_with_myself

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def create_demand_digest
    self.demand_token = User.new_token
    self.demand_digest = User.digest(demand_token)
  end

  def send_demand_activation_email
    UserMailer.demand_activation(self).deliver_now
  end

  def send_demand_email
    UserMailer.demand(self).deliver_now
    self.update_attributes(demanded_at: Time.current)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def demand_activate
    update_columns(demand_activated: true)
  end

  private
end
