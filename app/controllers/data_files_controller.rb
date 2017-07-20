class DataFilesController < ApplicationController
  before_action :find_plug

  def upload
    file = params[:data_file]

    ImportDataFromFile.new(@plug, file.tempfile).call

    @plug.data_files.create!(filename: file.path)

    redirect_to plug_path(@plug)
  end

  private

  def find_plug
    @plug = Plug.find(params[:id])
  end
end
