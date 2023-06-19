class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:new, :edit, :create, :update, :destroy]

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  def user_index
  #  @user = User.find(params[:user_id])
  #  @rooms = @user.card.rooms
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    begin
      @room = Room.find(params[:id])
      user = current_user
      card = current_user.card
      
      if user.isAdmin? || (card.rooms.exists?(@room.id) && card.status? && !card.lost?)
        usage_history = UsageHistory.new(card: card, room: @room)
        usage_history.save

      else
        flash[:unsuccesful] = 'You do not have access to this page.'
        redirect_to rooms_path
      end
    rescue ActiveRecord::RecordNotFound
      flash[:unsuccesful] = 'Not such room in database.'
      redirect_to rooms_path
    end
    
  #  @cards = @room.cards
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)

    if @room.save
    #  @room.card_id = params[:room][:card_id]  # Przypisanie card_id
      @room.save
      redirect_to @room
    else
      render :new
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
    @room = Room.find(params[:id])
      if @room.update(room_params)
        format.html { redirect_to room_url(@room), notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room = Room.find(params[:id])
    @room.usage_histories.destroy_all
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name, :description)
    end

    def check_admin
      unless current_user.isAdmin
        redirect_to root_path
    end
  end
end
