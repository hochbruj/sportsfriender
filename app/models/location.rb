class Location < ActiveRecord::Base
  
  acts_as_gmappable :lat => "lat", :lng => "lng", :process_geocoding => false
  
  attr_accessible :address, :city_id, :lat, :lng, :name, :private, :sport_id, :telephone, :city_name, :website

  belongs_to :city
  belongs_to :sport
  belongs_to :user
  has_many :events, :dependent => :destroy
  
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }
  validates :address, :presence => true,
                    :length   => { :maximum => 50 }
  validates :city_name, :presence => true
  
 
 geocoded_by :full_address,  :latitude => :lat, :longitude => :lng
 after_validation :geocode

def full_name
 "#{name}, #{address}"
end
                    
def full_address
  unless city.nil?
  "#{address}, #{city.full_name}"
  end
end

def dist(origin,unit)
  if unit == "km"
  conv = 1.609344
  else
  conv = 1
  end
  return distance = (self.distance_from(City.find_by_longtext(origin)) * conv).round(2).to_s + " " + unit
end

def city_name
  city.try(:full_name)
end

def city_name=(name)
  self.city = City.find_by_full_name(name) unless name.blank?
end

def self.valid_entries(sport_id,city_id,user_id) 
  @locations = self.where(city_id: city_id)
  @locations = @locations.where(sport_id: sport_id)
  @locations.delete_if{|l|
    (l.private? and l.user.groups.empty? and l.user_id != user_id) or 
    (l.private? and l.user.groups.exists? and 
     (l.user.groups.each do |g|
       break if g.members.where(user_id: user_id).exists?
       puts true
            end) and l.user_id != user_id)
  }
end
     
     

end