class User < ApplicationRecord
  # Scope
  default_scope { order(:name) }
  scope :active , -> { where(deleted: false, enabled: true) }

  # Associations
  has_one :wallet, -> { where(deleted: false, enabled: true) }, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
  validates :name, presence: true
  validates :user_type, presence: true
end
