class Dungeon < ActiveRecord::Base
	# Uses the events string from the dungeon to randomly select a 
	# event to return, weighted based on the events string
	# events string format is eventid:weight;eventid:weight;
	# weight should be around 50 on average
	def get_random_event
		events_pickuplist = Hash.new(0)
		events_probabilities_list = self.events.scan(/(\d+):(\d+);/)
		events_probabilities_list.each do |event|
			# event[0] is the eventid, event[1] is the weight
			events_pickuplist[ event[0].to_i ] = event[1].to_i
		end
		Pickup.new(events_pickuplist).pick
	end
end
