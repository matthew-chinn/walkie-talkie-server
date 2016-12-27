class ProfileController < ApplicationController
    def home
    end

    def create
        p = Profile.create(profile_params)
        if p.errors.any?
            err = p.errors.join(" ")
            render text: err
            return
        else
            #give them a key and return it
            p.update_attribute(:key, p.hash)
            render text: "#{p.hash}"
        end
    end

    def add_partner
        p = Profile.find(params[:id])
        if not Profile.exists?(key: params[:partner])
            render text: "Partner Key not valid"
            return
        end
        partner = Profile.find_by(key: params[:partner])
        p.update_attribute(:partner_id, partner.id)
        if partner.partner_id == nil or partner.partner_id != p.id
            render text: "Cannot send messages until partner adds you back"
            return
        else
            render text: "You and your partner are now connected!"
            return
        end
    end

    private
    def profile_params
        params.require(:profile).permit(:name, :email)
    end
end
