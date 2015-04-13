class Quest < ActiveRecord::Base
	before_save :complete_quest

	def percent_complete 
		(Time.zone.today.day-self.start_day.day)*100/self.goal
	end

	def percent_last_record
		self.last_record > Time.zone.today.day-self.start_day.day ? (self.last_record*100/self.goal)-percent_complete : 0
	end

	def percent_left 
		100-percent_complete-percent_last_record
	end

	private
		def complete_quest
			self.rank = "Newborn"
			self.start_day = Time.new(2015, 4, 10)#Time.zone.beginning_of_day
			self.last_record = 7
		end
end
