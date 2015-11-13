class DungeonsController < ApplicationController
  before_action :set_dungeon, only: [:show, :edit, :update, :destroy]

  # GET /dungeons
  def index
    @dungeons = Dungeon.all
  end

  # GET /dungeons/1
  def show
		if current_user
			# Get a random event from the events stack
			@random_event = DunEvent.offset(rand(DunEvent.count)).first
			handle_effect(@random_event.effect)
			
			# Knock off 10 motivation
  		updated_motivation = current_user.cur_motivation - 10
			current_user.update_column(:cur_motivation, updated_motivation)
			
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
    def handle_effect(effect)
			if effect == "hurt" then
    		updated_dignity = current_user.cur_dignity - 2
				current_user.update_column(:cur_dignity, updated_dignity)
			end
    		
    end
    
end
