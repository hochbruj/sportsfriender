require 'rails_helper'

RSpec.describe User, :type => :model do
      it "should create a User" do
        expect { user = User.create(email: "tiiit@tesmail.de")}.not_to raise_error
      end
      
      it "User update without city error" do
        expect { user.update(email: "tiiit@tesmail.de")}.not_to raise_error
      end

end
