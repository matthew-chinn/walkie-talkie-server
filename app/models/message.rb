class Message < ActiveRecord::Base
    belongs_to :profile
    validates :text, presence: true
end
