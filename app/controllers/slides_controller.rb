class SlidesController < ApplicationController
  def index
    if params[:t]
      Tracker.create(:from => params[:t])
    end
    if params[:tag_id]
      @slides = Slide.tagged_with(params[:tag_id]).order("created_at DESC").page(params[:page].to_i)
      @count = Slide.tagged_with(params[:tag_id]).count
    elsif params[:username]
      username = params[:username].gsub("&#183;", ".")
      @slides = Slide.where(:username => username).order("created_at DESC").page(params[:page].to_i)
      @count = Slide.where(:username => username).count
    elsif params[:search_box]
      @slides = Slide.where(["title LIKE ?", "%#{params[:search_box]}%"]).order("created_at DESC").page(params[:page].to_i)
      @count = Slide.where(["title LIKE ?", "%#{params[:search_box]}%"]).count
    else
      @slides = Slide.order("created_at DESC").page(params[:page].to_i)
      @count = Slide.count
    end
    @tags = Slide.tag_counts_on(:tags).sort_by(&:count).reverse[0..250]
  end

  def feed
    if params[:username]
      username = params[:username].gsub("&#183;", ".")
      @slides = Slide.where(:username => username).order('created_at DESC').limit(50)
    else
      @slides = Slide.order('created_at DESC').limit(50)
    end
    render :layout => false
  end
end
