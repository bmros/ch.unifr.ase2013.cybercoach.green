module SessionsHelper
  def sign_in(userlink)
    cookies.permanent.signed[:remember_token] = [userlink.id, userlink.salt]
    self.current_userlink = userlink
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_userlink = nil
  end
  
  def current_userlink=(userlink)
    @current_userlink = userlink
  end
  
  def current_userlink
    @current_userlink ||= userlink_from_remember_token
  end

  def signed_in?
    !current_userlink.nil?
  end  
  
  private

   #FIXME --------------------------------------------
    def userlink_from_remember_token
      UserLink.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end

end
