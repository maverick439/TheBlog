class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller? 
	before_action :authenticate_user!, except: [:index]

	def hello
		render text: "Hello World!"
	end

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:account_update, keys: [:image])
	end
end
