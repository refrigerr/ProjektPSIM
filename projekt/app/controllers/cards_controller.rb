class CardsController < ApplicationController
  before_action :authenticate_user!, only: %i[ show edit update destroy ]
  before_action :check_admin, only: [:index, :add_room, :new, :edit, :create, :destroy, :unassign_room]

  # GET /cards or /cards.json
  def index
    @cards = Card.all
  end

  def add_room
    @card = Card.find(params[:card_id])
    @room_id = params[:room_id]
    @room = Room.find_by(id: @room_id)

    if @room.nil?
      flash[:notfound] = "Nie znaleziono pokoju!"
      return
    end

    if @card.rooms.exists?(@room.id)
      flash[:alert] = "Pokój jest już przypisany do karty!"
      redirect_to @card
    else
      if @card.rooms << @room
        if @card.save
          flash[:success] = "Pomyślnie przypisano pokój do karty!"
        else
          flash[:fail] = "Nastąpił problem przy przypisywaniu pokoju do karty"
        end
      else
        flash[:notfound] = "Wybrany pokój nie istnieje!"
      end

      redirect_to @card
    end
  end

  # GET /cards/1 or /cards/1.json
  def show
    @card = Card.find_by_id(params[:id])
    @rooms = Room.all
    if @card.nil?
        redirect_to root_path
    else
        @rooms = Room.all
        if current_user.isAdmin
        else
            if @card.present? && @card.user == current_user
            else
              redirect_to root_path
            end
        end
    end
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
    @card = Card.find(params[:id])
    if @card.present?
    else
      redirect_to root_path
    end
  end

  # POST /cards or /cards.json
  def create
    @card = Card.new(card_params)
    @card.status = true
    respond_to do |format|
      if @card.save
        format.html { redirect_to card_url(@card), notice: "Card was successfully created." }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    @user = current_user
    @card = Card.find(params[:id])

    respond_to do |format|
    @card = Card.find(params[:id])
      if @card.update(card_params)
        
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url, notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def unassign_room
    @card = Card.find(params[:id])
    @room = @card.rooms.find(params[:room_id])
    # Remove the association from the card
    @card.rooms.delete(@room)
    if @room.save && @card.save
      redirect_to @card, notice: 'Room unassigned successfully.'
    else
      redirect_to @card, notice: ':(.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.require(:card).permit(:status, :lost)
    end

    def check_admin
      unless current_user.isAdmin
        redirect_to root_path
    end
  end
end
