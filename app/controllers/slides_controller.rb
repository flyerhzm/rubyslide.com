class SlidesController < ApplicationController
  def index
    if params[:tag_id]
      @slides = Slide.tagged_with(params[:tag_id]).paginate(:page => params[:page], :order => 'slides.created_at DESC')
      @count = Slide.tagged_with(params[:tag_id]).count
    elsif params[:search_box]
      @slides = Slide.all(:conditions => ["title LIKE ?", "%#{params[:search_box]}%"]).paginate(:page => params[:page], :order => 'slides.created_at DESC')
      @count = Slide.count(:conditions => ["title LIKE ?", "%#{params[:search_box]}%"])
    else
      @slides = Slide.paginate :page => params[:page], :order => 'slides.created_at DESC'
      @count = Slide.count
    end
  end
end
