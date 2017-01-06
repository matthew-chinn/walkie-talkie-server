class ProfileController < ApplicationController
    skip_before_action :verify_authenticity_token

    def home
        if profile_signed_in?
           redirect_to profile_path(current_profile.id)
           return
        end
        @partial = "home"
        render 'layouts/layout'
    end

    def show
        @profile = Profile.find(params[:id])
        @sent_messages = Message.where(sender_id: @profile.id, 
                                       profile_id: @profile.partner_id)
        @partial = "show"
        render 'layouts/layout'
    end

    def destroy
        p = Profile.find(params[:id])
        p.delete
        redirect_to root_url
    end

    def add_partner
        p = Profile.find(params[:id])
        res = p.add_partner(params[:partner])
        flash[:notice] = res
        redirect_to profile_url(p)
    end

    def remove_partner
        p = Profile.find(params[:id])
        p.update_attribute(:partner_id, nil)
        redirect_to profile_url(p)
    end

    def get_message
        p = Profile.find(params[:id])
        @message = p.remove_oldest_message
        if @message == nil
            render text: "false"
        else
            render json: @message #for now
        end
    end

    private
    def profile_params
        params.require(:profile).permit(:name, :email)
    end
end
