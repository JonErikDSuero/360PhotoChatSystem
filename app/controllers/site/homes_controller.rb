class Site::HomesController < ApplicationController

  def frontpage
    @curr_account = self.curr_account # refactor later
    @image_url = view_context.image_path('city.jpg')
    redirect_to '/visuals/feed' if @curr_account.present?
  end

end

