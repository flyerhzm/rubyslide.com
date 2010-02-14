class Slide < ActiveRecord::Base
  acts_as_taggable_on :tags
  validates_uniqueness_of :url

  def self.per_page
    10
  end
end
