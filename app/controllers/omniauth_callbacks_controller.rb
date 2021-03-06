# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    generic_callback('facebook')
  end

  def google_oauth2
    generic_callback('google_oauth2')
  end

  def generic_callback(provider)
    @identity = Identity.find_for_oauth request.env['omniauth.auth']
    # TODO: check if find_by email isn't a security vulnerability situation!
    # For ex if facebook user sets her password to sth that she knows
    # other user has, then it's possible to overtake foreign account as your own
    # Needs to be checked.
    @user = @identity.user || current_user || User.find_by(email: @identity.email)

    if @user.nil?
      @user = User.create(email: @identity.email || '')
      @identity.update_attribute(:user_id, @user.id)
    end

    if @user.email.blank? && @identity.email
      @user.update_attribute(:email, @identity.email)
    end

    if @user.persisted?
      @identity.user = @user
      @identity.save
      # We've created the user manually, and Device expects a
      # FormUser class (with the validations)
      @user = FormUser.find(@user.id)
      sign_in_and_redirect(@user, event: :authentication)
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
