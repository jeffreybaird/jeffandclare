class Category < ActiveRecord::Base

  def locations
    @location ||= []
  end

end