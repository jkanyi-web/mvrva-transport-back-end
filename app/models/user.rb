class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :services

  ROLES = %w{admin user}
  after_initialize :set_default_role, if: :new_record?

  ROLES.each do |role_name|
    define_method "#{role_name}?" do
      role == role_name
    end
  end

  def set_default_role
    self.role ||= 'user'
  end

  def self.revoke_jwt(_payload, user)
    user.update(jti: SecureRandom.uuid)
  end
end
