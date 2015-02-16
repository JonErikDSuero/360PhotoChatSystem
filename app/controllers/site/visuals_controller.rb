class Site::VisualsController < ApplicationController

  def googledrive
    puts params
    @current_account = Account.find_by(type: "google", user_id: JSON.parse(params[:state])["userId"])
    @current_account.api = Api::Google.new(@current_account)
    filenames = @current_account.api.download_files!(params["state"]["ids"])
    @image_url = view_context.image_path(filenames[0]) # assume 1 file for now
  end

end

