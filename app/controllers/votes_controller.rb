class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all
    if params[:poll]
      @poll = Poll.find(params[:poll])
      respond_to do |format|
        if Vote.find_by_ip_and_poll_id(request.remote_ip, @poll.id) == nil
          format.html { redirect_to "#{new_vote_url}?poll=#{@poll.id}", notice: 'You have not voted for this poll yet. Cast a vote to view results.' }
        end
      end
    else
      @poll = Poll.new
    end
    
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @vote = Vote.new
    @vote.poll_id = Poll.find(params[:poll]).id
    @answers = Answer.where(:poll_id => params[:poll])
  end

  # GET /votes/1/edit
  def edit
    @answers = Answer.where(:poll_id =>@vote.answer.poll.id)
  end

  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(vote_params)
    @vote.ip = request.remote_ip
    @vote.browser = Vote.browser_detection(request.env['HTTP_USER_AGENT'])
    #latitude and longitude detection for later
    respond_to do |format|
      if Vote.find_by_ip_and_poll_id(@vote.ip, @vote.poll_id)
        format.html { redirect_to "#{polls_url}", notice: 'You have already cast a successful vote for this poll. Try another one.' }        
      elsif @vote.save
        format.html { redirect_to "#{votes_url}?poll=#{@vote.answer.poll.id}", notice: 'Vote was successfully cast.' }
        format.json { render action: 'show', status: :created, location: @vote }
      else
        format.html { render action: 'new' }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votes/1
  # PATCH/PUT /votes/1.json
  def update
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to polls_url, notice: 'Vote was successfully cast.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:answer_id, :poll_id)
    end
end
