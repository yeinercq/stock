class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy, :trigger]

  def index
    # if params[:status].present?
    #   @status = params[:status]
    #   @invoices = current_company.invoices.status_value(@status)
    # else
    #   @invoices = current_company.invoices.ordered
    # end

    # It receives keys->values to filter invoice index 
    @invoices = Invoice.where(nil).ordered
    filtering_params(params).each do |key, value|
      @invoices = @invoices.public_send("filter_by_#{key}", value).ordered if value.present?
    end
  end

  def show
  end

  def new
    @invoice = current_company.invoices.build
  end

  def create
    @invoice = current_company.invoices.build(invoice_params)

    if @invoice.save
      respond_to do |format|
        format.html { redirect_to invoice_path(@invoice), notice: "Invoice was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Invoice was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @invoice.update(invoice_params)
      respond_to  do |format|
        format.html { redirect_to invoices_path, notice: "Invoice was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Invoice was successfully updated." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @invoice.destroy
      respond_to do |format|
        format.html { redirect_to invoices_path, notice: "Invoice was successfully destroyed." }
        format.turbo_stream { flash.now[:notice] = "Invoice was successfully destroyed." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def trigger
    respond_to do |format|
      Invoices::TriggerEvent.new.call(@invoice, params[:event])
      format.html {redirect_to invoice_path(@invoice), notice: "Invoice status was successfully changed." }
      format.turbo_stream { flash.now[:notice] = "Invoice status was successfully changed." }
    end
  end

  private

  def filtering_params(params)
    params.slice(:status, :client, :code)
  end

  def set_invoice
    @invoice = current_company.invoices.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:client_id)
  end
end
