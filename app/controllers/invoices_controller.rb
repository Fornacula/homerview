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
    ####################################################################
    months = Invoice.user_invoices_period_uniq_month_names(current_user)
    ms_hash = {}
    months.map { |m| ms_hash[m.to_sym] = nil }
    arr = [['months'] + months]
    services.each do |s|
      invoices = @invoices.where(service_id: s.id)
      periods = invoices.joins(:period).pluck(:period_start)#.map{ |p| I18n.t('date.month_names')[p.month-1] }
      arr << [s.name]
      ms_hash.each do |el|
        i = invoices.joins(:period).find_by('period_start = ?', Date.new(2017, (I18n.t('date.month_names').index(el[0].to_s.downcase) + 1), 1) )
        if i
          arr.last << i.price.to_f
        else
          arr.last << 0
        end
      end
    end
    @data = arr.transpose#[
    binding.pry
      #['kuu', 'elekter', 'vesi'],
      #['september', 47.8, 0],
      #['oktoober', 49.1, 20.5],
      #['november', 50.3, 0]
    #] #@data.transpose
  end
end
