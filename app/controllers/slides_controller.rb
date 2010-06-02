class SlidesController < ApplicationController
  def index
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
    @slides = Slide.all(:limit => 50, :order => 'created_at DESC')
    render :layout => false
  end
end
