class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  def index
    @invoices = current_company.invoices.ordered
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
        format.html { redirect_to invoices_path, notice: "Invoice was successfully created." }
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

  private

  def set_invoice
    @invoice = current_company.invoices.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:customer_id)
  end
end
