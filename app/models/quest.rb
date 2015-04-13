class Quest < ActiveRecord::Base
	before_save :finalize_quest
	validates :name, presence: true
	validates :goal, presence: true, numericality: { only_integer: true, greater_than: 0}

	# Determine what percent toward goal has been achieved
	def percent_complete 
		(Date.today-self.start_day).to_i*100/self.goal
	end

	# Determine what percent from current progress until last known record, if any
	def percent_last_record
		self.last_record > (Date.today-self.start_day).to_i ? (self.last_record*100/self.goal)-percent_complete : 0
	end

	# Determine what percent left until user reaches goal
	def percent_left 
		100-percent_complete-percent_last_record
	end

	private
		def finalize_quest
			self.rank = "Newborn"
			self.start_day = Date.today-4.days
			self.last_record = 7
		end
end
