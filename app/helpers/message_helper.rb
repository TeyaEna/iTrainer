module MessageHelper
  def screen_name_changer(name, current_user)
    if name == current_user
      "Me"
    else
      name
    end
  end
end