class Slide < ActiveRecord::Base
  acts_as_taggable_on :tags

  def self.per_page
    10
  end
end
