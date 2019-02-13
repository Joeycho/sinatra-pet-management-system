class Helper

  def self.current_owner
    if session[:owner_id]==nil
      false
    else
      Owner.find(session[:owner_id])
    end
  end

end
