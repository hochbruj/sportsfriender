class Group < ActiveRecord::Base
  attr_accessible :name, :user_tokens, :user_id
  has_many :members, :dependent => :destroy
  has_many :users, :through => :members
  belongs_to :user
  attr_reader :user_tokens

  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }
  
  
  def user_tokens=(ids)
    if self.id.nil?
      self.save
      ids.split(",").each  do |id|
        Member.create(:group_id => self.id, :user_id => id)
      end
    else
    self.user_ids = ids.split(",")
    end
  end

#  def user_tokens=(ids)
#      self.user_ids = ids.split(",")
#  end

end

