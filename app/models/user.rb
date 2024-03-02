class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

<<<<<<< HEAD
  validates :nickname,  presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, format: { with: /\A[\p{katakana}\u{30fc}]+\z/, message: "はカタカナで入力してください" }
  validates :first_name_kana, format: { with: /\A[\p{katakana}\u{30fc}]+\z/, message: "はカタカナで入力してください" }
  validate :password_complexity
  validates :birthday, presence: true

  private

  def password_complexity
    return if password.blank? || password.match?(/\A(?=.*?\d)(?=.*?[a-zA-Z])[a-zA-Z\d]+\z/)

    errors.add :password, 'は半角英数字混合で入力してください'
  end
=======
  has_many :items
  has_many :purchases

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :birthday, presence: true
>>>>>>> cb74faa3b3ae88c6b5f1a265fda1220158b5fde1
end
