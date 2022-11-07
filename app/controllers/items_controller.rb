class ItemsController < ApplicationController
  before_action :set_invoice
  before_action :set_item, only: [:edit, :update, :destroy]

  def new
    @item = @invoice.items.build
  end

  def create
    @item = @invoice.items.build(item_params)

    if @item.save
      respond_to do |format|
        format.html { redirect_to invoice_path(@invoice), notice: "Item was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Item was successfully created." }
        # Updates total attribute to invoice
        update_invoice_total
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    # Updates total attribute to invoice
    update_invoice_total

    if @item.update(item_params)
      respond_to do |format|
        format.html { redirect_to invoice_path(@invoice), notice: "Item was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Item was successfully updated." }
        # Updates total attribute to invoice
        update_invoice_total
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.destroy
      respond_to do |format|
        format.html { redirect_to invoice_path(@invoice), notice: "Item was successfully destroyed." }
        format.turbo_stream { flash.now[:notice] = "Item was successfully destroyed." }
        # Updates total attribute to invoice
        update_invoice_total
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def update_invoice_total
    # @invoice.total = @invoice.total_price
    @invoice.update(total: @invoice.total_price)
  end

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
