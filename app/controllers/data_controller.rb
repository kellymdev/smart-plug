class DataController < ApplicationController
  before_action :find_plug

  def record_data
    login_details = PerformHnapLogin.new(@plug).call
    RecordPlugData.new(@plug, login_details).call
  end

  private

  def find_plug
    @plug = Plug.find(params[:plug_id])
  end
end
