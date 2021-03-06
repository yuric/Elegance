class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy]

  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
  end

  # GET /polls/new
  def new
    @poll = Poll.new
    2.times {@poll.answers.build}# if @poll.answers.empty?
  end

  # GET /polls/1/edit
  def edit
    if @poll.poll_has_votes?
      respond_to do |format|
        format.html { redirect_to polls_url, alert: 'Poll already has votes. Can not be edited.' }
        format.json { head :no_content }
      end
    elsif @poll.i_own?(request.remote_ip)
    else
      respond_to do |format|
        format.html { redirect_to polls_url, alert: 'No permission to edit this poll. IP Spoof much?' }
        format.json { head :no_content }
      end
    end
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)
    @poll.ip = request.remote_ip
    # @poll.answers.build(params[:poll][:answers])
    respond_to do |format|
      if @poll.save && @poll.answers.build(params[:poll][:answers])
        format.html { redirect_to polls_url, notice: 'Poll was successfully created.' }
        format.json { render 'show', status: :created, location: @poll }
      else
        format.html { render 'new' }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    respond_to do |format|
      
      if @poll.update(poll_params)
        format.html { redirect_to polls_url, notice: 'Poll was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render 'edit' }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:question, answers_attributes: [:id, :poll_id, :content, :_destroy])
    end
end
