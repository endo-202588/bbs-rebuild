class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :posts

    validates :password,
            length: { minimum: 4 },
            if: -> { new_record? || will_save_change_to_crypted_password? }

  validates :password,
            presence: true,
            confirmation: true,
            if: -> { new_record? || will_save_change_to_crypted_password? }

  validates :password_confirmation,
            presence: true,
            if: -> { new_record? || will_save_change_to_crypted_password? }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :display_name,
            presence: true,
            length: { maximum: 30 }

  before_validation :downcase_email

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
