# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def tag_name
    if params[:tag_id]
      params[:tag_id]
    end
  end
end
