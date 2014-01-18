class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :admin, :city_reference, :comment, :dob, :email, :first_name, :gender, :image, :last_name, :provider, :sport_id, :uid, :password, :password_confirmation, :remember_me
  attr_accessible :city_name, :avatar , :delete_avatar, :lat, :lng, :city_reference, :country_code, :city_id
  attr_accessor :delete_avatar, :city_name
  attr_writer :skill
  
  belongs_to :sport
  has_many :pointers, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_many :stats, :dependent => :destroy
  has_many :participants, :dependent => :destroy
  has_many :event_posts, :dependent => :destroy
  has_many :events, :through => :participants
  has_many :members, :through => :groups, :dependent => :destroy
  has_many :groups, :dependent => :destroy
  has_many :feedbacks
  
  
  validates :first_name, :last_name, :gender, :sport, :dob, :presence => true, :on => :update
  validate :check_city, :on => :update
  

 
  
  has_attached_file :avatar, :styles => { :medium => "100x100#", :thumb => "50x50#" }
  validates_attachment_size :avatar, :less_than => 1.megabytes
  before_validation { avatar.clear if delete_avatar == '1' }
  
  reverse_geocoded_by :lat, :lng
  after_validation :geocode

  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      if auth.extra.raw_info.location?
        location_id = auth.extra.raw_info.location.id
      end
      user = User.create(first_name:auth.extra.raw_info.first_name,
                          last_name:auth.extra.raw_info.last_name,
                          gender:auth.extra.raw_info.gender,
                          image: auth.info.image,
                          dob: Date::strptime(auth.extra.raw_info.birthday,"%m/%d/%Y"),
                          provider:auth.provider,
                          uid:auth.uid,
                          email:auth.info.email,
                          password:Devise.friendly_token[0,20]
                           )
    end
    user
  end
  
  def check_city
    errors.add(:city_name, I18n.t('not_valid')) unless city_reference.present?
  end
  
  def new_stat(sport_id)
       @stat = stats.new
       @stat.sport_id = sport_id
       @stat.cat1 = ratings.average(:cat1, :conditions => "sport_id = #{sport_id}")
       @stat.cat2 = ratings.average(:cat2, :conditions => "sport_id = #{sport_id}")
       @stat.cat3 = ratings.average(:cat3, :conditions => "sport_id = #{sport_id}")
       @stat.cat4 = ratings.average(:cat4, :conditions => "sport_id = #{sport_id}")
       @stat.cat5 = ratings.average(:cat5, :conditions => "sport_id = #{sport_id}")
       @stat.save
  end
  
  def no_ratings(sport_id)
   no_ratings = ratings.count(:conditions => "sport_id = #{sport_id}")
  end
  
   
  def last_stat(sport_id)
    stats.where(:sport_id => sport_id).order('created_at DESC').first
  end
  
  def age
    unless dob.nil?
    return (Date.today.year - dob.year)
    end
  end
  
  def skill_text(sport_id,cat)
    Assessment.where(sport_id: sport_id, level: last_stat(sport_id)["cat#{cat}"].round).first["cat#{cat}"] unless Assessment.where(sport_id: sport_id, level: last_stat(sport_id)["cat#{cat}"].round).empty? 
  end
  
  
  def full_name
   "#{first_name} #{last_name}"
  end
  

  def profile_complete?
    unless ratings.empty?
      return true
    end
  end
  
  def not_rated
    not_rated = [] 
    Sport.all.each do |sport| 
      if ratings.find_by_sport_id(sport.id).nil?
      not_rated << sport
      end
     end
     return not_rated
  end
  
  def rated
    rated = [] 
    Sport.all.each do |sport| 
      rated << sport unless ratings.find_by_sport_id(sport.id).nil?
    end
     return rated
  end
  

  def participate?(event_id)
    participants.find_by_event_id(event_id)  
  end
  
  def completed_events
    completed = []
     events.where("finish_at <= ?", DateTime.now).order('finish_at DESC').each do |e|
      if e.participants.count > 1 and e.cancelled.nil?
      completed << e
      end
     end
     return completed
  end
  
  
  def chart_all
  legend = []
  data_total = []
  labels = []
  labels_total = []

   Sport.all.each do |s|
    unless stats.find_by_sport_id(s.id).nil?
  #initialize variable
    labels = []
    data = []
    x = []
  #create legend 
    legend << s.name
  #order stats per sport descending
     x = stats.where(sport_id: s.id).sort_by { |k| k[:created_at] }.reverse
  #count down months up to one year  
      11.downto(0) do |count|
        rating = nil
        labels << Date.today.months_since(-1*count).strftime("%B")[0]
  #get rating value per date
          x.each do |z|
            if DateTime.now.months_since(-1*count) >= z.created_at
              rating = z.total_skill
              break
            end
          end
         if rating == nil 
         rating = x.last.total_skill
         end
         data << rating
      end 
  #add data per sport to total array
   data_total << data  
    end
   end
  labels_total[0] = labels
  return data_total,labels_total,legend
  end

  def chart_per_sport(sport)
  legend = []
  data_total = []
  labels = []
  labels_total = []
  x = []
  #order stats per sport descending
     x = stats.where(sport_id: sport).sort_by { |k| k[:created_at] }.reverse 

  #iterate over categories
   1.upto(5) do |i|
    unless Sport.find_by_id(sport)["cat#{i}"] == 'nil'
  #initialize variable
    labels = []
    data = []

  #create legend 
    legend << Sport.find_by_id(sport)["cat#{i}"]
  #count down months up to one year  
      11.downto(0) do |count|
        rating = nil
        labels << Date.today.months_since(-1*count).strftime("%B")[0]
  #get rating value per date
          x.each do |z|
            if DateTime.now.months_since(-1*count) >= z.created_at
              rating = z["cat#{i}"]
              break
            end
          end
         if rating == nil 
         rating = x.last["cat#{i}"]
         end
         data << rating
      end 
  #add data per sport to total array
   data_total << data  
    end
   end
  labels_total[0] = labels
  return data_total,labels_total,legend
  end 
  
  def self.search(sport_id,city)
    if sport_id
       results = []
       users = self.near(city, 100, :units => :mi)
       users.each do |u|
         results << u unless u.stats.where(sport_id: sport_id).empty?
       end
     return results          
    end
  
  end
  

 def country_ranking(sport_id)
   ranking = []
   User.where(country_code: self.country_code).each do |u|
     unless u.stats.where(sport_id: sport_id).empty?
       u[:skill] = u.last_stat(sport_id).total_skill
       ranking << u
     end
   end
   return ranking.sort_by{|r| r[:skill]}.reverse!.index(ranking.detect{|r| r[:id] == self.id}) + 1
       
 end  
 
 def ranking(sport_id)
    ranking = []
    User.where(city_reference: self.city_reference).each do |u|
      unless u.stats.where(sport_id: sport_id).empty?
        u[:skill] = u.last_stat(sport_id).total_skill
        ranking << u
      end
    end
    return ranking.sort_by{|r| r[:skill]}.reverse!.index(ranking.detect{|r| r[:id] == self.id}) + 1
  end



def progress(sport)
  v = chart_per_sport(sport)[0]
   a_c = []
    (1..5).each do |c|
     unless Sport.find(sport)["cat#{c}"] == 'nil'
     a_t = []
      [1,3,11].each do |t|
       a_n = []
       number_abs = nil
       number_perc = nil
       number_abs = v[c-1].to_a[11].to_f - v[c-1].to_a[11-t].to_f
       number_perc = (v[c-1].to_a[11].to_f - v[c-1].to_a[11-t].to_f)/v[c-1].to_a[11-t].to_f * 100
       a_n << number_abs
       a_n << number_perc
       a_t << a_n
      end
     a_c << a_t
     end
    end
   return a_c
end
     
  

def progress_total(sport,a_p,act_total)
  a_t = []
   (0..2).each do |t|
    a_n = []
    total_abs = a_p[0][t][0]
    total_perc = a_p[0][t][1]
    (2..5).each do |c|
     unless a_p[c-1].nil?   
      total_abs += a_p[c-1][t][0]
      total_perc += a_p[c-1][t][1]
     end
    end
    a_n << (total_abs / Sport.find(sport).catcount)
    a_n << (((total_abs / Sport.find(sport).catcount) / (act_total - (total_abs / Sport.find(sport).catcount))) * 100)
    a_t << a_n
   end
  return a_t
end



end
