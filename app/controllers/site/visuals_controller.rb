class Site::VisualsController < ApplicationController

  def googledrive
    @current_account = Account.find_by(type: "google", user_id: params["state"]["userId"]).first
    @current_account.api = Api::Google.new(@current_account)
    files = @current_account.api.fetch_files(params["state"]["ids"])
    @image = files[0]
  end

end

