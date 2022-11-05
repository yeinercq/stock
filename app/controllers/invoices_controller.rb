class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  def index
    @invoices = Invoice.ordered
  end

  def show
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      redirect_to invoices_path, notice: "Invoice was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @invoice.update
      redirect_to invoices_path, notice: "Invoice was successfully updated."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @invoice.destroy
      redirect_to invoices_path, notice: "Invoice was successfully destroyed."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:customer_id)
  end
end
