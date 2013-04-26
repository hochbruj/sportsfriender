class City < ActiveRecord::Base
  translates :name, :full_name
  attr_accessible :country, :full_name, :lat, :lng, :name, :zone
  
  geocoded_by :full_name,  :latitude => :lat, :longitude => :lng
    after_validation :geocode
    
  def self.from_fb(id)
     unless id.nil?
        place = JSON.parse(open("https://graph.facebook.com/#{id}").read)
        unless City.near("#{place['location']['latitude']}, #{place['location']['longitude']}", 10).empty?
          City.near("#{place['location']['latitude']}, #{place['location']['longitude']}", 10).first.id
        end
      end
  end
  
end
