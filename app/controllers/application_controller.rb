# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_user

  def new; end

  def show; end

  def edit; end

  private

  def set_user
    user_signed_in? && @user = User.find(current_user.id)
  end
end
