class ProvidersController < ApplicationController
  before_action :set_provider, only: [:edit, :update, :destroy]

  def index
    @providers = Provider.ordered
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(provider_params)

    if @provider.save
      respond_to do |format|
        format.html { redirect_to providers_path, notice: "Provider was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Provider was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @provider.update(provider_params)
      respond_to do |format|
        format.html { redirect_to providers_path, notice: "Provider was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Provider was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @provider.destroy
    respond_to do |format|
      format.html { redirect_to providers_path, notice: "Provider was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Provider was successfully destroyed." }
    end
  end

  private

  def set_provider
    @provider = Provider.find(params[:id])
  end

  def provider_params
    params.require(:provider).permit(:name, :email, :phone_number)
  end

end
