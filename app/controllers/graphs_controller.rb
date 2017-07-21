class GraphsController < ApplicationController
  before_action :find_plug

  def consumption_data
    respond_to do |format|
      format.json {
        render json: @plug.readings.order(:date_time).as_json(only: [:date_time, :consumption])
      }
    end
  end

  def temperature_data
    respond_to do |format|
      format.json {
        render json: @plug.readings.order(:date_time).as_json(only: [:date_time, :temperature])
      }
    end
  end

  private

  def find_plug
    @plug = Plug.find(params[:plug_id])
  end
end
