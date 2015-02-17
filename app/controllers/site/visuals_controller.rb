class Site::VisualsController < ApplicationController

  before_action :require_login, except: :googledrive

  def googledrive # refactor later
    state = JSON.parse(params[:state])
    account = Account.find_by(type: Api::Google::TYPE, user_id: state["userId"])
    account.api = Api::Google.new(account)
    session[:curr_account_id] = account.id.to_s
    @curr_account = self.curr_account

    filenames = account.api.download_files!(state["ids"])
    @image_url = "/#{filenames[0]}" # assume 1 file for now
  end

  def feed
    # last 10
    @images = Visual::Image.all.desc('_id').limit(10)
  end

end

