class InvoicesController < ApplicationController

  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  before_action :set_services, only: [:new, :edit]
  before_action :get_index_data, only: [:index]

  def new; end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.user = current_user
    if @invoice.save
      redirect_to invoices_path, notice: t('invoices.successful_save')
    else
      redirect_to new_invoice_path, alert: @invoice.errors.full_messages.join(', ')
    end
  end

  def show
    @service = @invoice.service
  end

  def edit; end

  def update
    if @invoice.update(invoice_params)
      redirect_to invoices_path, notice: t('invoices.successful_update')
    else
      redirect_to invoice_path, alert: @invoice.errors.full_messages.join(', ')
    end
  end

  def destroy
    if @invoice.destroy
      redirect_to invoices_path, notice: t('invoices.successful_destroy')
    else
      redirect_to invoices_path, alert: @invoice.errors.full_messages.join(', ')
    end
  end

  def index; end

  private

  def invoice_params
    params.require(:invoice).permit(
      :invoice_nr, :service_id, :user_id, :price, :comment
    )
  end

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def set_services
    @services = Service.all
  end

  def get_index_data
    @library_options = {
      title: t('graphs.yearly_summary.title'),
      xtitle: t('graphs.yearly_summary.x-title'),
      ytitle: t('graphs.yearly_summary.y-title'),
      download: true,
    }
    @invoices = current_user.invoices
    services = Service.where(id: @invoices.pluck(:service_id).uniq)
    @data = []
    services.each do |s|
      invoices = @invoices.where(service_id: s.id)
      points = invoices.each.map { |i| [l(i.created_at, format: :default), i.price] }
      @data << {name: s.name, data: points}
    end
  end
end
