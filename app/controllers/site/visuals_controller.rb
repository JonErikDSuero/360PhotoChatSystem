class Site::VisualsController < ApplicationController

  before_action :require_login, except: :googledrive

  def feed
    @images = Visual::Image.all.desc('_id').limit(10) # last 10
  end

  def show
    @can_go_back_to_feed = true
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

  def post_from_googledrive
    @image = Visual::Image.new(
      account_api_user_name: @curr_account.api_user_name,
      account_id: @curr_account.id.to_s,
      type: Api::Google::TYPE,
      image: File.open("public"+params[:image_url])
    )
    @image.save!

    redirect_to controller: "site/visuals", action: "show", id: @image.id.to_s
  end

  def googledrive # refactor later
    state = JSON.parse(params[:state])
    account = Account.find_by(type: Api::Google::TYPE, api_user_id: state["userId"])
    account.api = Api::Google.new(account)
    session[:curr_account_id] = account.id.to_s
    @curr_account = self.curr_account

    filenames = account.api.download_files!(state["ids"])
    @image_url = "/#{filenames[0]}" # assume 1 file for now
    @googledrive = true
  end

end

