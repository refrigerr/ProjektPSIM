class UsageHistoriesController < ApplicationController
  before_action :set_usage_history, only: %i[ show edit update destroy ]

  # GET /usage_histories or /usage_histories.json
  def index
    if current_user.isAdmin
      @usage_histories = UsageHistory.all
    else
      redirect_to root_path
    end
  end

  # GET /usage_histories/1 or /usage_histories/1.json
  def show
    if @card.present? && @card.user == current_user
    else
       redirect_to root_path, alert: "You don't have permission to access this card."
    end
  end

  # GET /usage_histories/1/edit
  def edit
  end

  # POST /usage_histories or /usage_histories.json
  def create
    @usage_history = UsageHistory.new(usage_history_params)

    respond_to do |format|
      if @usage_history.save
        format.html { redirect_to usage_history_url(@usage_history), notice: "Usage history was successfully created." }
        format.json { render :show, status: :created, location: @usage_history }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @usage_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usage_histories/1 or /usage_histories/1.json
  def update
    respond_to do |format|
      if @usage_history.update(usage_history_params)
        format.html { redirect_to usage_history_url(@usage_history), notice: "Usage history was successfully updated." }
        format.json { render :show, status: :ok, location: @usage_history }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @usage_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usage_histories/1 or /usage_histories/1.json
  def destroy
    @usage_history.destroy

    respond_to do |format|
      format.html { redirect_to usage_histories_url, notice: "Usage history was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usage_history
      @usage_history = UsageHistory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def usage_history_params
      params.require(:usage_history).permit(:when_used)
    end
end
