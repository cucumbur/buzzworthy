class DungeonsController < ApplicationController
  before_action :set_dungeon, only: [:show, :edit, :update, :destroy]

  # GET /dungeons
  def index
  	redirect_to dead_path if current_user.dead?
    @dungeons = Dungeon.all
  end

  # GET /dungeons/1
  def show
		if current_user
			redirect_to dead_path if current_user.dead?
			# Get a random event from the events stack
			@random_event = DunEvent.offset(rand(DunEvent.count)).first
			handle_effect(@random_event.effect)
			
			# Knock off 10 motivation
  		updated_motivation = current_user.cur_motivation - 10
			current_user.update_attribute(:cur_motivation, updated_motivation)
			
		else
  		flash[:danger] = "You must be logged in to do that."
  		redirect_to root_url
		end
  end

  # GET /dungeons/new
  def new
    @dungeon = Dungeon.new
  end

  # GET /dungeons/1/edit
  def edit
  end

  # POST /dungeons
  def create
    @dungeon = Dungeon.new(dungeon_params)

    if @dungeon.save
      redirect_to @dungeon, notice: 'Dungeon was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /dungeons/1
  def update
    if @dungeon.update(dungeon_params)
      redirect_to @dungeon, notice: 'Dungeon was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /dungeons/1
  def destroy
    @dungeon.destroy
    redirect_to dungeons_url, notice: 'Dungeon was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dungeon
      @dungeon = Dungeon.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dungeon_params
      params.require(:dungeon).permit(:name, :description)
    end
    
    # Every event has an effect, and this decodes that and decides how to respond
    # effect notation: EFFECTTYPE:VALUE;EFFECTTYPE:VALUE etc
    def handle_effect(effect_string)
    	effect_list = effect_string.split(';')
    	effect_list.each do |effect|
    		effect_type = (/(\w+)[:](\w+)/.match(effect))[1]
    		effect_value = (/(\w+)[:](\w+)/.match(effect))[2]
    		
    		case effect_type
				when "hurt"
		    	updated_dignity = current_user.cur_dignity - effect_value.to_i
					updated_dignity = current_user.max_dignity if updated_dignity > current_user.max_dignity
					current_user.update_column(:cur_dignity, updated_dignity)
				when "heal"
					updated_dignity = current_user.cur_dignity + effect_value.to_i
					updated_dignity = current_user.max_dignity if updated_dignity > current_user.max_dignity
					current_user.update_column(:cur_dignity, updated_dignity)
				when "steal"
					updated_money = current_user.money - effect_value.to_i
					updated_money = 0 if updated_money < 0
					current_user.update_column(:money, updated_money)
				when "fund"
					updated_money = current_user.money + effect_value.to_i
					current_user.update_column(:money, updated_money)
				end
				
			end
    		
    end
    
end
