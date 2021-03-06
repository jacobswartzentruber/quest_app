class Quest < ActiveRecord::Base
	belongs_to :user
	before_create :set_start_day
	validates :name, presence: true
	validates :goal, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
	validates :user_id, presence: true

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
		# If goal reached, set percent to 100
		days_complete < self.goal ? days_complete*100/self.goal : 100
	end

	# Determine what percent from current progress until last known record, if any
	def percent_last_record
		days_last_record*100/self.goal
	end

	# Determine what percent left until user reaches goal
	def percent_left 
		100-percent_complete-percent_last_record
	end

	private
		def set_start_day
			self.start_day = Date.today
		end
end
