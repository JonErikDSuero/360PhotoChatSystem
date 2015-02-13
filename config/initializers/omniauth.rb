Rails.application.config.middleware.use OmniAuth::Builder do

  #provider :developer unless Rails.env.production?

  provider :google_oauth2,
    "995906368455-qvaefh019sbutj0qq20q5bv6pcoovo8u.apps.googleusercontent.com",
    Rails.application.secrets.google_oauth2

end

