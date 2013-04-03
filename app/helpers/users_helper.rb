module UsersHelper
  def picture_for(user)
     if user.avatar?
     image_tag(user.avatar.url(:thumb), :class => 'img-polaroid', :size => '50x50')
     else
       if user.image
         image_tag(user.image,  :class => 'img-polaroid', :size => '50x50')
       else
          case user.gender
             when nil
               image_tag('user.png', :class => 'img-polaroid', :size => '50x50')
             when 'female'
               image_tag('woman_user.png', :class => 'img-polaroid', :size => '50x50')
             when 'male'
               image_tag('man_user.png', :class => 'img-polaroid', :size => '50x50')
          end
       end
                                     
    end            
   end


 




end
