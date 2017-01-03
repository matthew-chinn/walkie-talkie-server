class ProfileController < ApplicationController
    skip_before_action :verify_authenticity_token

    def home
        render text: "Profile home"
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
            render text: p.as_json
        end
    end

    def show
        p = Profile.find(params[:id])
        render text: p.as_json
    end

    def destroy
        p = Profile.find(params[:id])
        txt = "#{p.name} deleted\n"
        p.delete
        render text: txt
    end

    def add_partner
        p = Profile.find(params[:id])
        res = p.add_partner(params[:partner])
        render text: res
    end

    def pop_message
        p = Profile.find(params[:id])
        render p.pop_message
    end

    private
    def profile_params
        params.require(:profile).permit(:name, :email)
    end
end
