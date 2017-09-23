class ChessHomeController < ApplicationController
  include ChessHomeHelper

  protect_from_forgery :except => :create_game

  def index
  	@online_users = online_users
  end

  def create_game
  	time = params[:time]
  	ranked = params[:ranked].to_b
  	teamate = params[:player2]	
  	player3 = params[:player3]	
  	player4 = params[:player4]	
	
  	response = find_players(time, ranked, teamate, player3, player4)

  	teamate = User.first
  	player3 = teamate = player4
	
  	if (!response["player2"].nil? && !response["player3"].nil? && !response["player4"].nil?)
      players_ids = [current_user.id, response["player2"].id_user, response["player3"].id_user, response["player4"].id_user]
      chess_game = ""
      ChessGame.transaction do
        chess_game = ChessGame.where(id_player1: players_ids, id_player2: players_ids, id_player3: players_ids, id_player4: players_ids).order("created_at").last
        puts players_ids
        puts "-" * 100
        if (chess_game == nil)
      		chess_game = ChessGame.create(id_player1: current_user.id, id_player2: response["player2"].id_user, id_player3: response["player3"].id_user, id_player4: response["player4"].id_user)
        end
      end
  		response["id_game"] = chess_game.id
  	end

    puts response.to_s
    respond_to do |format|
    	format.json { render json: response}
    end

  end

  def cancel_search
  	if (!current_user.nil?)
	  	PendingPlayer.where(id_user: current_user.id).destroy_all
	end

    respond_to do |format|
    	format.json { render json: {}}
    end
  end

end
