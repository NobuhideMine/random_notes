# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
 
    before_action :user_state, only: [:create]

    def guest_sign_in
        user = User.guest
        sign_in user
        redirect_to user_path(user), notice: "I logged in as a guest user."
    end

    def after_sign_out_path_for(resource)
        posts_path
    end

    protected
    
    def user_state
        @user = User.find_by(email: params[:user][:email])
        if @user
            if @user.valid_password?(params[:user][:password]) && (@user.is_active == false)
                flash[:notice] = "It is currently stopped. Please register again and use the service."
                redirect_to new_user_registration_path
            else
                flash[:notice] = "Please enter the item"
            end
        else
            flash[:notice] = "No matching users found"
        end
    end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
