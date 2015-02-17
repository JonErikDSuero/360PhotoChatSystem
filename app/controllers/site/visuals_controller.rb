class Site::VisualsController < ApplicationController

  before_action :require_login, except: :googledrive

  def googledrive # refactor later
    state = JSON.parse(params[:state])
    account = Account.find_by(type: Api::Google::TYPE, api_user_id: state["userId"])
    account.api = Api::Google.new(account)
    session[:curr_account_id] = account.id.to_s
    @curr_account = self.curr_account

    filenames = account.api.download_files!(state["ids"])
    @image_url = "/#{filenames[0]}" # assume 1 file for now
  end

  def feed
    @images = Visual::Image.all.desc('_id').limit(10) # last 10
  end

  def show
    @image = Visual::Image.find(params[:id])
  end

  def upload
    image = Visual::Image.new(
      account_api_user_name: params[:account_api_user_name],
      account_id: params[:account_id],
      type: params[:type],
      image: params[:file]
    )
    image.save!

    redirect_to "/visuals/feed"
  end

end

