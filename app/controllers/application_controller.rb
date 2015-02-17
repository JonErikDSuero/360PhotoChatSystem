class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def curr_account
    @curr_account ||= Account.find(session[:curr_account_id])
  end

  def require_login
    if curr_account.blank?
      redirect_to '/homes/frontpage'
    else
      @curr_account = self.curr_account
    end
  end

end
