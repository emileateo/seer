class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :preferences, dependent: :destroy
  has_many :categories, through: :preferences, dependent: :destroy
  has_many :posts, through: :categories, dependent: :destroy

  def preferred_posts

    @user_categories = self.categories
    @posts = Post.where(category: @user_categories)

  end
end
