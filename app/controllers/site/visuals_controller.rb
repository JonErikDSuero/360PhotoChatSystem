class Site::VisualsController < ApplicationController

  def googledrive
    state = JSON.parse(params[:state])
    @current_account = Account.find_by(type: "google", user_id: state["userId"])
    @current_account.api = Api::Google.new(@current_account)
    filenames = @current_account.api.download_files!(state["ids"])
    @image_url = "/#{filenames[0]}" # assume 1 file for now
  end

end

