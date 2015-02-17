class SessionsController < ApplicationController

  def create
    account = Account.find_or_create_from_auth_hash!(auth_hash)
    session[:curr_account_id] = account.id.to_s
    redirect_to '/visuals/feed'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end

