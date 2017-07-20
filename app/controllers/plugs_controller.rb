class PlugsController < ApplicationController
  before_action :find_plug, only: [:show, :edit, :update]

  def index
    @plugs = Plug.all.order(:id)
  end

  def new
    @plug = Plug.new
  end

  def create
    @plug = Plug.new(plug_params)

    if @plug.save
      redirect_to plug_path(@plug)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @plug.update(plug_params)
      redirect_to plug_path(@plug)
    else
      render :edit
    end
  end

  private

  def plug_params
    params.require(:plug).permit(:name, :login_user, :login_password, :ip_address)
  end

  def find_plug
    @plug = Plug.find(params[:id])
  end
end
