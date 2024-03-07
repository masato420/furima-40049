class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true
  validates :password_confirmation, presence: true
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥ー]+\z/ }
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥ー]+\z/ }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥ー]+\z/ }
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナで入力してください。' }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナで入力してください。' }
  validates :birthday, presence: true
  validate :password_complexity

  private

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]{6,}$/

    errors.add(:password, 'は半角英字と数字をそれぞれ1種類以上含む必要があります')
  end
end
