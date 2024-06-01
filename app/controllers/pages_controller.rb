class PagesController < ApplicationController
  def home
    @latest_dramas = Drama.order('created_at DESC').limit(3)
  end

  def about
    @favorite_drama = Drama.where(title: ["Death's Game", "Reply 1988", "Move to Heaven"]).order(created_at: :desc)
  end
end
