class Profiles::SessionsController < Devise::SessionsController
    skip_before_action :verify_authenticity_token
    # before_filter :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    def new
        super 
    #    @partial = "profiles/sessions/new"
    #    render 'layouts/layout'
    end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    # protected

    # You can put the params you want to permit in the empty array.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.for(:sign_in) << :attribute
    # end
end
