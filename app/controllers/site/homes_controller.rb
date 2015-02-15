class Site::HomesController < ApplicationController

  def frontpage
    @image_url = view_context.image_path('city.jpg')
  end

end

