class Profile < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
    has_many :messages

    validates :email, presence: true, uniqueness: true

    def remove_oldest_message
        begin
            m = Message.where(profile_id: self.id, sender_id: self.partner_id)
                       .order(:created_at).first
        rescue #if no latest message, return ""
            return nil
        end
        if m == nil
            return nil
        end

        m.destroy
        return m
    end

    def add_partner(partner_key)
        if not Profile.exists?(key: partner_key)
            return "Partner Key not valid"
        end

        partner = Profile.find_by(key: partner_key)
        self.update_attribute(:partner_id, partner.id)

        if partner.partner_id == nil or partner.partner_id != self.id
            return "Connected! Cannot send messages until partner adds you back"
        else
            return "You and your partner are now connected!"
        end
    end

    def has_partner?
        return self.partner_id ? true : false
    end

    def partner
        p = Profile.find(self.partner_id)
        return p
    end
end
