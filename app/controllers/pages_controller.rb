class PagesController < ApplicationController
  def home
    @latest_dramas = Drama.order('created_at DESC').limit(3)
  end

  def about
  end
end
