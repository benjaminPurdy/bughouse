module ChessHomeHelper

	RANDOM = "---RANDOM---"

	def find_players(time, ranked, player2, player3, player4)
		random_players_count = random_players_count([player2, player3, player4]) 
		matched_random_players = []
		matched_specific_players = []
		return_json = {}

		matched_random_players |= PendingPlayer.where("ranked = ? AND matched = ? AND id_user != ?", ranked, false, current_user.id).take(random_players_count)

		if (player2 != RANDOM)
			puts RANDOM
			pending_player = PendingPlayer.where("ranked = ? AND matched = ? AND id_user = ?", ranked, true, player2)
			matched_specific_players | [pending_player]
			return_json["player2"] = pending_player.id_user
		else
			return_json["player2"] = matched_random_players.shift
		end

		if (player3 != RANDOM)
			pending_player = PendingPlayer.where("ranked = ? AND matched = ? AND id_user = ?", ranked, true, player3)
			matched_specific_players | [pending_player]
			return_json["player3"] = pending_player.id_user
		else
			return_json["player3"] = matched_random_players.shift
		end

		if (player4 != RANDOM)
			pending_player = PendingPlayer.where("ranked = ? AND matched = ? AND id_user = ?", ranked, true, player4)
			matched_specific_players | [pending_player]
			return_json["player4"] = pending_player.id_user
		else
			return_json["player4"] = matched_random_players.shift
		end

		matched_players = (matched_random_players | matched_specific_players)

		if (matched_players.length < 3)
			if (random_players_count < 3)
				PendingPlayer.find_or_create_by(ranked: ranked, matched: true, id_user: current_user.id)
			else
				PendingPlayer.find_or_create_by(ranked: ranked, matched: false, id_user: current_user.id)
			end
		end

		if (matched_players.length == 3) 
			matched_players.each(&:destroy)
		end

		return_json

	end

private

	def random_players_count(players)
		count = 0
		players.each do |player|
			if (player == RANDOM)
				count = count + 1
			end
		end
		count
	end
end