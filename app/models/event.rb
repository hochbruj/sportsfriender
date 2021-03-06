class Event < ActiveRecord::Base
  attr_accessible :age_from, :age_to, :cancelled, :city_id, :creason, :emails, :finish_at, :gender, :group_id, :info, :location_id, :max_part, :mode, :private,
                 :skill_from, :skill_to, :sport_id, :start_at, :type_id, :date, :hour_start, :min_start, :hour_fin, :min_fin, :am_pm_start, :am_pm_fin,
                 :repeat, :rep_every, :rep_end, :location_search, :loc_reference, :loc_id, :loc_lat, :loc_lng, :loc_name
  attr_accessor :hour_start, :min_start, :hour_fin, :min_fin, :am_pm_start, :am_pm_fin, :num_part, :repeat, :rep_every, :rep_end, :location_search,
                :loc_reference, :loc_id, :loc_lat, :loc_lng, :loc_name
                

  belongs_to :city
  belongs_to :sport
  belongs_to :location
  belongs_to :type
  belongs_to :group
  
  has_many :participants
  has_many :event_posts
  
  validates  :mode, :gender, :max_part, :presence => true
  validate :check_date, :check_from_to
  
  HOURS_EN = ['01','02','03','04','05','06','07','08','09','10','11','12']
  HOURS = ['00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23']
  MINUTES = ['00','05','10','15','20','25','30','35','40','45','50','55']
 
  def date
      self.start_at.strftime(date_format)
   end
   
  def date=(date)
     begin
         self.start_at = DateTime.strptime( date, date_format)
     rescue ArgumentError
      false
     end
   end   
   
  def check_date
    unless self.start_at.nil?
    errors.add(:date, I18n.t('start_past')) unless (self.start_at > DateTime.now)
    errors.add(:date, I18n.t('start_end')) unless (self.finish_at > self.start_at)
    end
  end
  
  
  def check_from_to
    errors.add(:skill_to, I18n.t('check_from_to'))unless (skill_from <= skill_to)
    errors.add(:age_to, I18n.t('check_from_to'))unless (age_from <= age_to)
  end
  
  
  def set_time
      d = DateTime.strptime( date, date_format)
      Time.zone = self.location.timezone
      self.start_at = Time.zone.parse("#{d.year}-#{d.month}-#{d.day} #{hour_start}:#{min_start}#{am_pm_start}")
      self.finish_at = Time.zone.parse("#{d.year}-#{d.month}-#{d.day} #{hour_fin}:#{min_fin}#{am_pm_start}")
  end

  def set_location
      Location.create_with(name: loc_name, lat: loc_lat, lng: loc_lng, reference: loc_reference, timezone: Timezone.lookup(loc_lat, loc_lng).name).find_or_create_by_sport_id_and_google_id(sport_id,loc_id) 
  end



   
   def save_set_organizer(user)
     errors.add(:age_from, I18n.t('include_age'))unless (age_from <= user.age)
     errors.add(:age_to, I18n.t('include_age'))unless (age_to >= user.age)
     errors.add(:skill_from, I18n.t('include_skill'))unless (skill_from <= user.last_stat(self.sport_id).total_skill)
     errors.add(:skill_to, I18n.t('include_skill'))unless (skill_to >= user.last_stat(self.sport_id).total_skill)
     errors.add(:location_search, I18n.t('not_valid')) unless loc_reference.present?
     if self.errors.any?
       return false
     else
     @part = self.participants.new
     @part.user_id = user.id
     @part.organizer = true
     self.set_location
     self.location_id = Location.find_by_google_id(self.loc_id).id
     self.set_time
     if self.save and @part.save
       return true
     else
       return false
     end 
     end  
   end
   
   def spots_left
      max_part - participants.count
    end
   
    def organizer
      participants.find_by_organizer(true)
    end
   
    def num_part
      participants.count
    end

    def rated_part(user)
      count = 0
      participants.each do |p|
         count = count + 1 if p.unrated?(user)
      end
      return count, participants.count - count
    end
    
    def self.search(sport_id,lat,lng,radius,units)
      if sport_id and lat and lng
         @events = self.where("start_at >= ?", DateTime.now)
         @events = @events.where(sport_id: sport_id)
         @events = @events.where(private: false)
         @events = @events.where(cancelled: nil)
         @events = @events.where("location_id IN (?)", Location.near([lat,lng], radius, :units => units.to_sym).map(&:id))
#         @events = @events.where("location_id IN (?)", Location.near(city, radius, :units => units.to_sym).map(&:id))
         @events = @events.order('start_at ASC')  
      end
    end
    
    def check_repeat(user)
     if repeat == '1'
       @event = self
       while (@event.start_at + rep_every.to_i.days) <= DateTime.strptime( rep_end, date_format)
       @event = @event.dup
       @event.start_at = @event.start_at + rep_every.to_i.days
       @event.finish_at = @event.finish_at + rep_every.to_i.days
       @event.save_set_organizer(user)
       end
     end
    end
    
    def invite
      unless self.emails.nil?
        emails.split(',').each do |m|
        UserMailer.event_invite(nil,m,self).deliver    
        end
      end
      
      unless self.group.nil?
      self.group.users.each do |user|
      UserMailer.event_invite(user,user.email,self).deliver
      end
      end
    end
    
    def check_rating_complete!(user)
      notrated = 'false'
      participants.each do |p|
      if p.unrated?(user)
       notrated = 'true'
      end
     end
     unless notrated == 'true'
       participants.where(user_id: user.id).first.update_attributes(:rated => true)
     end
    end
    
    def rating_complete?(user)
      participants.find_by_user_id(user.id).rated     
    end
    
    def send_cancel(user)
      participants.each do |p|
      unless p.organizer?
      UserMailer.event_cancel(p.user,self).deliver
      end
      end
    end
    
    def start_in_location
      Time.zone = self.location.timezone
      return self.start_at.in_time_zone
    end
    
    def fin_in_location
      Time.zone = self.location.timezone
      return self.finish_at.in_time_zone
    end

private
   
    def date_format
       if I18n.locale == :en
         return "%m/%d/%Y"
       else
         return "%d/%m/%Y"
       end      
     end 
     
  
       
    
end
