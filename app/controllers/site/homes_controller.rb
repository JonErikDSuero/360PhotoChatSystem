class Site::HomesController < ApplicationController

  def frontpage
    @curr_account = self.curr_account # refactor later
    @image_url = view_context.image_path('city.jpg')
  end

end

