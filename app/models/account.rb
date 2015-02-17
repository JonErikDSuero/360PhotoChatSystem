class Account

  include Mongoid::Document

  field :type, type: String
  field :api_user_id, type: String
  field :api_user_name, type: String
  field :token, type: String
  field :refresh_token, type: String
  field :token_expires_at, type: DateTime

  validates_presence_of :type, :api_user_id, :api_user_name, :token, :refresh_token, :token_expires_at

  attr_accessor :api


  def self.find_or_create_from_auth_hash!(auth_hash)

    if Api::Google.type?(auth_hash)
      account = Account.find_by(
        type: Api::Google::TYPE,
        api_user_id: auth_hash[:uid]
      )

      if (account.blank?)
        account = Account.new(
          type: Api::Google::TYPE,
          api_user_id: auth_hash[:uid],
          api_user_name: auth_hash[:info][:name],
          token: auth_hash[:credentials][:token],
          refresh_token: auth_hash[:credentials][:refresh_token],
          token_expires_at: Time.at(auth_hash[:credentials][:expires_at])
        )
        account.save!
      end
    else
      # check other API Types such as Dropbox, Facebook, etc..
      # raise Exception for now..
    end

    return account
  end

end
