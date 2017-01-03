class MessageController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        m = Message.create(message_params)
        if m.errors.any?
            err = m.errors.join(" ")
            render text: err
            return
        else
            render text: m.as_json
        end
    end

    private
    def message_params
        params.require(:message).permit(:text, :profile_id, :sender_id)
    end
end
