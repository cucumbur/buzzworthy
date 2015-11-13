class DunEventsController < ApplicationController
  before_action :set_dun_event, only: [:show, :edit, :update, :destroy]

  # GET /dun_events
  def index
    @dun_events = DunEvent.all
  end

  # GET /dun_events/1
  def show
  end

  # GET /dun_events/new
  def new
    @dun_event = DunEvent.new
  end

  # GET /dun_events/1/edit
  def edit
  end

  # POST /dun_events
  def create
    @dun_event = DunEvent.new(dun_event_params)

    if @dun_event.save
      redirect_to @dun_event, notice: 'Dun event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /dun_events/1
  def update
    if @dun_event.update(dun_event_params)
      redirect_to @dun_event, notice: 'Dun event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /dun_events/1
  def destroy
    @dun_event.destroy
    redirect_to dun_events_url, notice: 'Dun event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dun_event
      @dun_event = DunEvent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dun_event_params
      params.require(:dun_event).permit(:name, :description, :effect)
    end
end
