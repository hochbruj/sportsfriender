class Event < ActiveRecord::Base
  attr_accessible :age_from, :age_to, :cancelled, :city_id, :creason, :emails, :finish_at, :gender, :group_id, :info, :location_id, :max_part, :mode, :private,
                 :skill_from, :skill_to, :sport_id, :start_at, :type_id, :date, :hour_start, :min_start, :hour_fin, :min_fin, :am_pm_start, :am_pm_fin
  attr_accessor :hour_start, :min_start, :hour_fin, :min_fin, :am_pm_start, :am_pm_fin

  belongs_to :city
  belongs_to :sport
  belongs_to :location
  belongs_to :type
  belongs_to :group
  
  has_many :participants
  has_many :event_posts
  
  validates :location_id, :mode, :gender, :max_part, :info, :presence => true
  validate :check_date, :check_from_to 
  
  HOURS_EN = ['01','02','03','04','05','06','07','08','09','10','11','12']
  HOURS = ['00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23']
  MINUTES = ['00','05','10','15','20','25','30','35','40','45','50','55']
 
  def date
    if self.start_at? and self.city_id?
    self.start_at.in_time_zone(self.city.zone).strftime("%m/%d/%Y")
    end
   end
   
  def date=(date)
     begin
     self.start_at = DateTime.strptime( date, "%m/%d/%Y")
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
      if (am_pm_start == 'PM' and hour_start != '12') or (am_pm_start == 'AM' and hour_start == '12')
      self.start_at = DateTime.new(start_at.year, start_at.month, start_at.day, (hour_start.to_i + 12), min_start.to_i, 0, time_offset)
      else
      self.start_at = DateTime.new(start_at.year, start_at.month, start_at.day, hour_start.to_i, min_start.to_i, 0, time_offset)
      end
      if (am_pm_fin == 'PM' and hour_fin != '12') or (am_pm_fin == 'AM' and hour_fin == '12')
      self.finish_at = DateTime.new(start_at.year, start_at.month, start_at.day, (hour_fin.to_i + 12), min_fin.to_i, 0, time_offset)
      else
      self.finish_at = DateTime.new(start_at.year, start_at.month, start_at.day, hour_fin.to_i, min_fin.to_i, 0, time_offset)
      end
  end

  
   def time_offset
      require 'tzinfo'
      case self.city.zone
      when 'Eastern Time (US & Canada)'
         zone = 'US/Eastern'
      when 'Pacific Time (US & Canada)'
        zone = 'US/Pacific'
      when 'Mountain Time (US & Canada)'
         zone = 'US/Mountain'
      when 'Central Time (US & Canada)'
           zone = 'US/Central'
      
      else
         zone = self.city.zone 
      end
      offset = (TZInfo::Timezone.get(zone).current_period.utc_total_offset / (60*60))
      if offset > 0
        return '+' + offset.to_s
      else 
        return offset.to_s
      end  
   end

   
   def save_set_organizer(user)
     errors.add(:age_from, I18n.t('age_higher'))unless (age_from <= user.age)
     errors.add(:age_to, I18n.t('age_lower'))unless (age_to >= user.age)
     errors.add(:skill_from, I18n.t('skill_higher'))unless (skill_from <= user.last_stat(self.sport_id).total_skill)
     errors.add(:skill_to, I18n.t('skill_lower'))unless (skill_to >= user.last_stat(self.sport_id).total_skill)
     if self.errors.any?
       return false
     else
     @part = self.participants.new
     @part.user_id = user.id
     @part.organizer = true
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
   


end
