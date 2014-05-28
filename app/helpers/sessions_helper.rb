module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token #create new token
		cookies.permanent[:remember_token] = remember_token #hashed tokens
		user.update_attribute(:remember_token, User.digest(remember_token)) #storing hashed tokens
		self.current_user = user #call current_user=(user)
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user #set current user
	end

	def current_user
		remember_token = User.digest(cookies[:remember_token]) #get hashed tokens from user's cookies
		@current_user ||= User.find_by(remember_token: remember_token) #compare hashed tokens
	end

	def current_user?(user)
		@current_user == user
	end

	def sign_out
		current_user.update_attribute(:remember_token, User.digest(User.new_remember_token)) #replace a new hashed tokens in database
		cookies.delete(:remember_token)
		self.current_user = nil
	end


	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end
end
