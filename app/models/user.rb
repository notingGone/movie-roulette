class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :list

  after_create :create_list

  delegate :movies, to: :list, allow_nil: true

  # def movies
  #   list.movies
  # end

  private

    def create_list
      List.find_or_create_by(user_id: id)
    end
end
