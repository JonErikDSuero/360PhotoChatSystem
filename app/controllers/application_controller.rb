class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def curr_account
    return nil if session[:curr_account_id].blank?
    @curr_account ||= Account.find(session[:curr_account_id])
  end

  def require_login
    @curr_account = self.curr_account
    redirect_to '/homes/frontpage' if @curr_account.blank?
  end

end
