class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :items

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: /\A[\p{Hiragana}\p{Katakana}\p{Han}ー－]+\z/ }
  validates :first_name, presence: true, format: { with: /\A[\p{Hiragana}\p{Katakana}\p{Han}ー－]+\z/ }
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナで入力してください。' }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナで入力してください。' }
  validates :birthday, presence: true
  validate :password_complexity

  private

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]{6,}$/

    errors.add(:password, 'は半角英字と数字の両方を含めて設定してください')
  end
end
