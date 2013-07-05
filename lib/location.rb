class Location < ActiveRecord::Base

  def category
    @category
  end

  def category=(category)
    @category = category
  end
end