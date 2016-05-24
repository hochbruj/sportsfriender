class Location < ActiveRecord::Base
  
  
  attr_accessible  :lat, :lng, :name, :sport_id, :reference, :google_id
  
  reverse_geocoded_by :lat, :lng
  
  belongs_to :sport
  has_many :events, :dependent => :destroy
  
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }



def dist(origin,unit)
  if unit == "km"
  conv = 1.609344
  else
  conv = 1
  end
  return distance = (self.distance_from(City.find_by_longtext(origin)) * conv).round(2).to_s + " " + unit
end

  
     

end
