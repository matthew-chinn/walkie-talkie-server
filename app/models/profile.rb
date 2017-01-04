class Profile < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
    has_many :messages

    validates :email, presence: true, uniqueness: true

    def remove_oldest_message
        begin
            m = Message.where(profile_id: self.id).order(:created_at).first
        rescue #if no latest message, return ""
            return ""
        end
        if m == nil
            return ""
        end

        txt = m.as_json
        m.destroy
        return txt
    end

    def add_partner(partner_key)
        if not Profile.exists?(key: partner_key)
            return "Partner Key not valid"
        end

        partner = Profile.find_by(key: partner_key)
        self.update_attribute(:partner_id, partner.id)

        if partner.partner_id == nil or partner.partner_id != self.id
            return "Cannot send messages until partner adds you back"
        else
            return "You and your partner are now connected!"
        end
    end
end
