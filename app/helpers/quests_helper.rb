module QuestsHelper
	RANK_NAMES = { 0 => ["Newborn", "1"], 1 => ["Fresh", "2"], 2 => ["Stubborn", "3"], 5 => ["Reliable", "4"], 10 => ["Solid", "5"],
								 20 => ["Devoted", "6"], 30 => ["Passionate", "7"], 45 => ["Master", "8"], 60 => ["Unique", "9"], 90 => ["Ultimate", "10"]}

	def get_rank_name(quest)
		exp = quest.days_complete
		rank = 0
		RANK_NAMES.each do |key, value|
			exp >= key ? rank = key : break
		end
		"\""+RANK_NAMES[rank][0]+"\" (Level "+RANK_NAMES[rank][1]+")"
	end

end
