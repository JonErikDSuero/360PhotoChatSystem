require 'rest_client'
require 'google/api_client'

class Api::Google


  def initialize(account)
    @account = account
    @client = Google::APIClient.new
    self.refresh_token_if_expired!
    @client.authorization.access_token = @account.token
    @drive = @client.discovered_api('drive', 'v2')
    self
  end


  def refresh_token_if_expired!
    if (@account.token_expires_at < Time.now - 1.minute)
      data = {
        client_id: Rails.application.secrets.google_oauth2_client_id,
        client_secret: Rails.application.secrets.google_oauth2_secret,
        refresh_token: @account.refresh_token,
        grant_type: "refresh_token"
      }
      @response = ActiveSupport::JSON.decode(RestClient.post "https://accounts.google.com/o/oauth2/token", data)
      if @response["access_token"].present?
        @account.token = @response["access_token"]
        @account.token_expires_at = Time.now.utc + @response["expires_in"].to_i.seconds
        @account.save
      end
    end
  end


  def download_files!(file_ids)
    filenames = [];
    dir_path = "googledrive/#{@account.user_id}/"
    public_dir_path = "public/"+dir_path

    file_ids.each do |file_id|

      result = @client.execute( api_method: @drive.files.get, parameters:{ fileId: file_id })
      filename = dir_path+result.data.title
      filenames << filename

      FileUtils.mkdir_p(public_dir_path) unless File.directory?(public_dir_path)
      file = @client.execute(uri: result.data.downloadUrl)
      File.open("public/"+filename, 'wb') do |f|
        f.write(file.body)
      end

    end

    filenames
  end

end

