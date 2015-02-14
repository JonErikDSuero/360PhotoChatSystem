class Account

  include Mongoid::Document

  field :type, type: String
  field :user_id, type: String
  field :token, type: String
  field :refresh_token, type: String
  field :token_expires_at, type: DateTime

  attr_accessor :api

end
