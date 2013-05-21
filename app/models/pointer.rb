class Pointer < ActiveRecord::Base
  attr_accessible :cat_id, :user_id
  belongs_to :user
end
