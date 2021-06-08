class HomeController < ApplicationController
  def top
    @hide_user_info = true
  end

  def about
    @hide_user_info = true
  end
end
