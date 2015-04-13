class QuestsController < ApplicationController

	def index
		@quests = Quest.all
	end

	def show
		@quest = Quest.find(params[:id])
	end

	def new
		@quest = Quest.new
	end

	def create
		@quest = Quest.new(quest_params)
		if @quest.save
			flash[:success] = "Quest successfully created"
			redirect_to quests_path
		else
			render 'new'
		end
	end

	private
		def quest_params
			params.require(:quest).permit(:name, :rank, :start_day, :goal, :last_record)
		end
end
