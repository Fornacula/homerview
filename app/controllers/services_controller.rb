# frozen_string_literal: true

class ServicesController < ApplicationController
  before_action :set_service, only: %i[show edit update destroy]

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to services_path, notice: t('services.successful_save')
    else
      redirect_to new_service_path, alert: @service.errors.full_messages.join(', ')
    end
  end

  def update
    if @service.update(service_params)
      redirect_to services_path, notice: t('services.successful_update')
    else
      redirect_to edit_service_path, alert: @service.errors.full_messages.join(', ')
    end
  end

  def destroy
    if @service.destroy
      redirect_to services_path, notice: t('services.successful_destroy')
    else
      redirect_to services_path, alert: @service.errors.full_messages.join(', ')
    end
  end

  def index
    @services = Service.all
  end

  private

  def service_params
    params.require(:service).permit(:name)
  end

  def set_service
    @service = Service.find(params[:id])
  end
end
