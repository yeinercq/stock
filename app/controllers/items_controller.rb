class ItemsController < ApplicationController
  before_action :set_invoice
  before_action :set_item, only: [:edit, :update, :destroy]

  def new
    @item = @invoice.items.build
  end

  def create
    @item = @invoice.items.build(item_params)

    if @item.save
      redirect_to invoice_path(@invoice), notice: "Item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to invoice_path(@invoice), notice: "Item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.destroy
      redirect_to invoice_path(@invoice), notice: "Item was successfully destroyed."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = @invoice.items.find(params[:id])
  end

  def set_invoice
    @invoice = Invoice.find(params[:invoice_id])
  end

  def item_params
    params.require(:item).permit(:product_id, :quantity, :unit_price)
  end
end
