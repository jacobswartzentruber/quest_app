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

	def reset
		@quest = Quest.find(params[:id])
		@quest.days_complete > @quest.last_record ? new_record = @quest.days_complete : new_record = @quest.last_record
		if @quest.update_attributes(start_day: Date.today, last_record: new_record)
			flash[:success] = "Quest reset!"
			redirect_to quests_path
		else
			flash[:warning] = "Quest reset failed"
			redirect_to quests_path
		end
	end

	private
		def quest_params
			params.require(:quest).permit(:name, :rank, :start_day, :goal, :last_record)
		end
end
