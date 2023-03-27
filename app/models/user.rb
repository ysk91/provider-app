class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,              presence: true,
                                length: { maximum: 50 }
                                # uniqueness: { scope: :group_id }
                                # format: false

  validates :email,             # presence: true,
                                # length: { maximum: 50 }
                                uniqueness: true
                                # format: false

  validates :uid,               # presence: true
                                # length: { maximum: 50 }
                                uniqueness: true
                                # format: false

  after_create :set_uid!

  private

  def set_uid!
    update(uid: SecureRandom.uuid)
  end

end
