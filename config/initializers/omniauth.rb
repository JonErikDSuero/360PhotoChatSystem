Rails.application.config.middleware.use OmniAuth::Builder do

  #provider :developer unless Rails.env.production?

  provider :google_oauth2,
    Rails.application.secrets.google_oauth2_client_id,
    Rails.application.secrets.google_oauth2_secret
  {
    scope: [
      "https://www.googleapis.com/auth/drive.file",
      "https://www.googleapis.com/auth/drive.install"
    ],
  }

end

