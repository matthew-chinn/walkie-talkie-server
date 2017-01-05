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
        redirect_to profile_path(p)
    end

    def get_message
        p = Profile.find(params[:id])
        @message = p.remove_oldest_message
        if @message == nil
            render text: "false"
        else
            puts("HELLO #{@message.text}")
            render json: @message #for now
        end
    end

    private
    def profile_params
        params.require(:profile).permit(:name, :email)
    end
end
