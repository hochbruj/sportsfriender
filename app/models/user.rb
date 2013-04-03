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
  has_many :ratings
  
  validates :first_name, :last_name, :gender, :sport, :city_name, :dob, :presence => true, :on => :update
  
  
  has_attached_file :avatar, :styles => { :medium => "100x100>", :thumb => "50x50>" }
  before_validation { avatar.clear if delete_avatar == '1' }
  
  GENDERS = [[ I18n.t("male"), 'male'],[ I18n.t("female"),'female']]
  
  
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
  
  

end
