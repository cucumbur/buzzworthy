class NewspostsController < ApplicationController
  before_action :set_newspost, only: [:show, :edit, :update, :destroy]

  # GET /newsposts
  def index
    @newsposts = Newspost.all
  end

  # GET /newsposts/1
  def show
  end

  # GET /newsposts/new
  def new
    @newspost = Newspost.new
  end

  # GET /newsposts/1/edit
  def edit
  end

  # POST /newsposts
  def create
    @newspost = Newspost.new(newspost_params)

    if @newspost.save
      redirect_to @newspost, notice: 'Newspost was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /newsposts/1
  def update
    if @newspost.update(newspost_params)
      redirect_to @newspost, notice: 'Newspost was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /newsposts/1
  def destroy
    @newspost.destroy
    redirect_to newsposts_url, notice: 'Newspost was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newspost
      @newspost = Newspost.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def newspost_params
      params.require(:newspost).permit(:content, :user_id)
    end
end
