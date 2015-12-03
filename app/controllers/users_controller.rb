class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :refresh]
  before_action :logged_in_user, only: [:index, :create, :update, :destroy]
  before_action :admin_user, only: [:destroy]

  # GET /users
  # GET /users.json
  def index
		if current_user and current_user.admin?
  		#@users = User.all
  		@users = User.paginate(page: params[:page])
		else
  		flash[:danger] = "Naughty, naughty..."
  		redirect_to root_url
		end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # Handle a successfully created user save
        @user.send_activation_email
        format.html { redirect_to root_path, notice: 'Check your email for an activation link in the next 5 minutes' }
        format.json { render :show, status: :created, location: @user }
      else
        # Handle instances where something went wrong
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def refresh
  	@user.refresh
  	flash[:success] = "User refreshed." 
  	redirect_to root_path
  end

	# Called after the user fills out the leveling up upgrade form
	# Should let them select EXACTLY AS many stats as they have upgrade points (default 2)
	# no more, no less, and apply genre level up bonuses
	def apply_level_up
		@user = current_user
		num_upgraded = 0
		#max_upgrade = @user.upgrade_points
		max_upgrade = 2
		
		(@user.update_attribute(:max_motivation, @user.max_motivation + 5); num_upgraded += 1) if params[:motivation] == '1' and num_upgraded < max_upgrade
		(@user.update_attribute(:max_dignity, @user.max_dignity + 5); num_upgraded += 1) if params[:dignity] == '1' and num_upgraded < max_upgrade
		(@user.update_attribute(:max_strangepoints, @user.max_strangepoints + 5); num_upgraded += 1) if params[:strangepoints] == '1' and num_upgraded < max_upgrade
		
		(@user.update_attribute(:verve, @user.verve + 1); num_upgraded += 1) if params[:verve] == '1' and num_upgraded < max_upgrade
		(@user.update_attribute(:heart, @user.heart + 1); num_upgraded += 1) if params[:heart] == '1' and num_upgraded < max_upgrade
		(@user.update_attribute(:allure, @user.allure + 1); num_upgraded += 1) if params[:allure] == '1' and num_upgraded < max_upgrade
		(@user.update_attribute(:strangeness, @user.strangeness + 1); num_upgraded += 1) if params[:strangeness] == '1' and num_upgraded < max_upgrade
		(@user.update_attribute(:serendipity, @user.serendipity + 1); num_upgraded += 1) if params[:serendipity] == '1' and num_upgraded < max_upgrade
		
		# The line below is the hardcoded verve upgrade in lieu of real genre upgrades
		@user.update_attribute(:verve, @user.verve + 1)
		
		#@user.update_attribute(:upgrade_points, max_upgrade-num_upgraded)
		
		@user.update_attribute(:buzz, @user.buzz - User.exp_to_reach_level(@user.level + 1) )
		@user.update_attribute(:level, @user.level+1)
		
		# flash[:danger] = "You aren't allowed to choose more than two, so only your first two choices were upgraded." 
		redirect_to @user, notice: 'Nice, you upgraded your stats!'
	end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :bio, :password, :password_confirmation, :gender, :cur_motivation, :forem_admin)
    end
end
