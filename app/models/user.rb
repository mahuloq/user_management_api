class User < ApplicationRecord
  before_create :downcase_email

  validates :full_name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { minimum: 5, maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 18, less_than: 100 }

  private

  def downcase_email
    self.email = email.downcase
  end
end


