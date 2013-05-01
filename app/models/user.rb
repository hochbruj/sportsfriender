class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :admin, :city_id, :comment, :dob, :email, :first_name, :gender, :image, :last_name, :provider, :sport_id, :uid, :password, :password_confirmation, :remember_me
  attr_accessible :city_name, :avatar , :delete_avatar
  attr_accessor :delete_avatar
  
  belongs_to :sport
  belongs_to :city
  has_many :ratings, :dependent => :destroy
  has_many :stats, :dependent => :destroy
  has_many :participants, :dependent => :destroy
  has_many :event_posts, :dependent => :destroy
  has_many :events, :through => :participants
  
  validates :first_name, :last_name, :gender, :sport, :city_name, :dob, :presence => true, :on => :update
  
  
  has_attached_file :avatar, :styles => { :medium => "100x100>", :thumb => "50x50>" }
  before_validation { avatar.clear if delete_avatar == '1' }
  
  
  
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
                          city_id: City.from_fb(location_id),
                          provider:auth.provider,
                          uid:auth.uid,
                          email:auth.info.email,
                          password:Devise.friendly_token[0,20]
                           )
    end
    user
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
  
  def full_name
   "#{first_name} #{last_name}"
  end
  
  def city_name
    city.try(:full_name)
  end

  def city_name=(name)
    self.city = City.find_by_full_name(name) unless name.blank?
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
  

  def participate?(event_id)
    participants.find_by_event_id(event_id)  
  end

end
