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

  def index
    gon.data = @data
    gon.options = @options
  end

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
    @invoices = current_user.invoices

    atm = Date.current
    x_axis = ((atm - 1.year)..atm).map { |m| m.month }.uniq
    graph_max_width = 12 # months
    oldest_invoice_period = @invoices.first.period_start
    if oldest_invoice_period > atm - 1.year
      # If user has less than one year invoices saved to db:
      graph_max_width = (atm.year * 12 + atm.month) - (oldest_invoice_period.year * 12 + oldest_invoice_period.month)
      x_axis = x_axis[(12 - graph_max_width)..-1]
    end

    # Different services that user consumes:
    services = Service.where(id: @invoices.pluck(:service_id).uniq)

    @data = [['months'] + x_axis]
    services.each do |s|
      invoices = @invoices.where(service_id: s.id)
      @data << [s.name] # add row for service-related invoice prices
      invoices.each do |i|
        if x_axis.include?(i.period_start.month)
          @data.last << i.price.to_f
        else
          @data.last << 0
        end
      end
      if @data.last.size != x_axis.size + 1
        (x_axis.size - @data.last.size + 1).times do
          @data.last << 0
        end
      end
    end
    binding.pry
    @options  = {
      title: t('graphs.yearly_summary.title'),
      hAxis: {
        title: t('graphs.yearly_summary.x-title'),
      },
      vAxis: {
        title: t('graphs.yearly_summary.y-title'),
      },
      download: true
    }
    @data = @data.transpose
  end
end
