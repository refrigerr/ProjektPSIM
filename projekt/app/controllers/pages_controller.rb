class PagesController < ApplicationController
	before_action :check_admin, only: [:show]
	
	def index	
	end

	def show
		@cards = Card.where(lost: true)
	end

	private
		def check_admin
		   unless current_user.isAdmin
		      redirect_to root_path
		   end
		end
end
