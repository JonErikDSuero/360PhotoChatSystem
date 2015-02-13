class Site::HomesController < ApplicationController

  def frontpage
    @image_url = view_context.image_path('sun.jpg')
  end

  def openwith
    puts params
  end

end

