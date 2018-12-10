class SuspectsController < ApplicationController
  before_action :check_login

  def index
  	@suspects = Suspect.alphabetical.all.to_a
  	@current_suspects = Suspect.current.alphabetical.to_a
  	#@previous_suspects = Suspect.!current.alphabetical.to_a
  end

  def new
  	@suspect = Suspect.new
  	@investigation = Investigation.find(params[:investigation_id])
  	unless params[:suspect_id].nil?
      @investigation = Investigation.find(params[:investigation_id])
    end
  end

  def create
    @suspect = Suspect.new(suspect_params)
    @suspect.added_on = Date.current
    if @suspect.save
      flash[:notice] = "Successfully added suspect."
      redirect_to investigation_path(@suspect.investigation)

    else
      @criminal = Criminal.find(params[:suspect][:criminal_id])
      @investigation = Investigation.find(params[:suspect][:investigation_id])
      render action: 'new', locals: { investigation: @investigation }
    end
  end

  def remove
  	@suspect = Suspect.find(params[:id])
    @suspect.dropped_on = Date.current
    @suspect.save
    redirect_to investigation_path(@suspect.investigation)
  end

  def suspect_params
  	params.require(:suspect).permit(:investigation_id, :criminal_id, :added_on, :droped_on)
  end
end
