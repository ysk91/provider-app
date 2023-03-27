# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  name                :string           default(""), not null
#  remember_created_at :datetime
#  uid                 :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
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
