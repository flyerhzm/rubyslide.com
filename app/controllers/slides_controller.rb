class SlidesController < ApplicationController
  def index
    if params[:t]
      Tracker.create(:from => params[:t])
    end
    if params[:tag_id]
      @slides = Slide.tagged_with(params[:tag_id]).paginate(:page => params[:page], :order => 'slides.created_at DESC')
      @count = Slide.tagged_with(params[:tag_id]).count
    elsif params[:username]
      @slides = Slide.find_all_by_username(params[:username]).paginate(:page => params[:page], :order => 'slides.created_at DESC')
      @count = Slide.find_all_by_username(params[:username]).count
    elsif params[:search_box]
      @slides = Slide.all(:conditions => ["title LIKE ?", "%#{params[:search_box]}%"]).paginate(:page => params[:page], :order => 'slides.created_at DESC')
      @count = Slide.count(:conditions => ["title LIKE ?", "%#{params[:search_box]}%"])
    else
      @slides = Slide.paginate :page => params[:page], :order => 'slides.created_at DESC'
      @count = Slide.count
    end
    @tags = Slide.tag_counts_on(:tags).sort_by(&:count).reverse[0..250]
  end

  def feed
    if params[:username]
      @slides = Slide.all(:conditions => ["username = ?", params[:username]], :limit => 50, :order => 'created_at DESC')
    else
      @slides = Slide.all(:limit => 50, :order => 'created_at DESC')
    end
    render :layout => false
  end
end
