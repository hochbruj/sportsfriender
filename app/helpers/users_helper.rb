module UsersHelper
  def picture_for(user)
     if user.avatar?
     image_tag(user.avatar.url(:thumb), :class => 'img-polaroid', :size => '50x50')
     else
       if user.image
         image_tag(user.image,  :class => 'img-polaroid', :size => '50x50')
       else
          if user.gender == 'female'
            image_tag('userfem_icon.png', :class => 'img-polaroid', :size => '50x50')
          else
            image_tag('user_icon.png', :class => 'img-polaroid', :size => '50x50')
          end
       end
                                     
    end            
   end


 




end
