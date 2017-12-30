# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!, :set_locale

  def new; end
  def show; end
  def edit; end

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
      locale :
      I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
