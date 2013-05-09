module ApplicationHelper
  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end
  
  def is_active?(lhn)
    if @lhn == lhn
    "lhn_active"
    else
    "lhn"
    end
  end
  
  def show_rated(level,dif)
    return  'worse wselected' if level == 'w' and dif == -1
    return  'same sselected' if level == 's' and dif == 0
    return  'better bselected' if level == 'b' and dif == 1
    return  'no' if level == 'w' and dif != -1
    return  'no' if level == 's' and dif != 0
    return  'no' if level == 'b' and dif != 1 
  end
  
end
