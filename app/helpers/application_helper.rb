module ApplicationHelper

  def admin?
    if current_user
      current_user.admin
    else
      false
    end
  end 

end
