class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :preferences, dependent: :destroy
  has_many :categories, through: :preferences, dependent: :destroy
  has_many :appointments
  has_many :posts, through: :categories, dependent: :destroy
  validates :birthdate, presence: true
  has_one_attached :photo

  monetize :price_cents

  def preferred_posts
    if self.categories.count == 0
      @user_categories = Category.all
    else
      @user_categories = self.categories
    end

    @posts = Post.where(category: @user_categories)
  end
end
