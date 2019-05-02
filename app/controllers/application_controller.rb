class ApplicationController < ActionController::Base
    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
    end

    # Remembers a user in a persistent session.
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    def current_user
        if session[:user_id]
          @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    # def current_user
    #     if (user_id = session[:user_id])
    #       @current_user ||= User.find_by(id: user_id)
    #     elsif user_id = cookies.signed[:user_id]
    #       user = User.find_by(id: user_id)
    #       if (user && Digest::SHA1.hexdigest(cookies[:remember_token]) == user.remember_digest)
    #         @current_user = user
    #       end
    #     end
    #   end

    def logged_in?
        !current_user.nil?
    end

    private
 
  def require_login
    unless logged_in?
      flash[:warning] = "You must be logged in to access this section"
      redirect_to login_url 
    end
  end

    def sign_out
        session.delete(:user_id)
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
        @current_user = nil
    end
end
