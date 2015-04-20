class QuestsController < ApplicationController
	before_action :authenticate_user!

	def index
		@quests = current_user.quests
	end

	def show
		@quest = current_user.quests.find(params[:id])
	end

	def new
		@quest = current_user.quests.build()
	end

	def create
		@quest = current_user.quests.build(quest_params)
		if @quest.save
			flash[:success] = "Quest successfully created"
			redirect_to quests_path
		else
			render 'new'
		end
	end

	def destroy
		current_user.quests.find(params[:id]).destroy
		flash[:success] = "Quest successfully deleted"
		redirect_to quests_path
	end

	# Reset current_days and last_record back to zero
	def reset
		@quest = current_user.quests.find(params[:id])
		# If quest already complete, update goal to last_record
		@quest.days_complete > @quest.goal ? new_goal = @quest.days_complete : new_goal = @quest.goal
		# If current days is the longest so far, update last_record
		@quest.days_complete > @quest.last_record ? new_record = @quest.days_complete : new_record = @quest.last_record
		if @quest.update_attributes(start_day: Date.today, last_record: new_record, goal: new_goal)
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
