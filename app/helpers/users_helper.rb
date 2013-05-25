module UsersHelper
  def picture_for(user,size = 50)
     if user.avatar?
     image_tag(user.avatar.url(:medium), :class => 'img-polaroid', :size => "#{size}x#{size}")
     else
       if user.image
         image_tag(user.image,  :class => 'img-polaroid', :size => "#{size}x#{size}")
       else
          if user.gender == 'female'
            image_tag('userfem_icon.png', :class => 'img-polaroid', :size => "#{size}x#{size}")
          else
            image_tag('user_icon.png', :class => 'img-polaroid', :size => "#{size}x#{size}")
          end
       end
                                     
    end            
   end


 




end
