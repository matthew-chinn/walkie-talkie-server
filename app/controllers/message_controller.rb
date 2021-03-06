class MessageController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        m = Message.create(message_params)
        if m.errors.any?
            err = m.errors.full_messages.join(" ")
            flash[:error] = err
        else
            flash[:success] = "Successfuly created message"
        end

        redirect_to profile_url(params[:message][:sender_id])
    end

    def delete
        m = Message.find(params[:id])
        m.delete
        redirect_to profile_url(params[:profile_id]), status: 303
    end

    private
    def message_params
        params.require(:message).permit(:text, :profile_id, :sender_id)
    end
end
