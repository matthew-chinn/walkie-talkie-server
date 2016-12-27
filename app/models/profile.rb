class Profile < ActiveRecord::Base
    has_many :messages
    validates :name, presence: true
    validates :email, presence: true
end
