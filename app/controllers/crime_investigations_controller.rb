class CrimeInvestigationsController < ApplicationController
  
  def new
  	@crime_investigation = CrimeInvestigation.new
  	@investigation = Investigation.find(params[:investigation_id])
  	render action: 'new', locals: { investigation: @investigation }
  end

  def create
  	@crime_investigation = CrimeInvestigation.new(crime_investigation_params)
  	if @crime_investigation.save
  	  flash[:notice] = "Successfully created investigation crime."
      redirect_to investigation_path(@crime_investigation.investigation)
    else
      @investigation = Investigation.find(params[:crime_investigation][:investigation_id])
      render action: 'new', locals: { investigation: @investigation }
    end
  end

  private
    def crime_investigation_params
      params.require(:crime_investigation).permit(:crime_id, :investigation_id)
    end

end
