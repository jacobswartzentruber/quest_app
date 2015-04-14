class Quest < ActiveRecord::Base
	validates :name, presence: true
	validates :goal, presence: true, numericality: { only_integer: true, greater_than: 0}

	def days_complete
		(Date.today-self.start_day).to_i
	end

	def days_last_record
		self.last_record > days_complete ? self.last_record-days_complete : 0
	end

	def days_left
		self.goal - days_complete - days_last_record
	end

	# Determine what percent toward goal has been achieved
	def percent_complete 
		days_complete*100/self.goal
	end

	# Determine what percent from current progress until last known record, if any
	def percent_last_record
		days_last_record*100/self.goal
	end

	# Determine what percent left until user reaches goal
	def percent_left 
		100-percent_complete-percent_last_record
	end
end
