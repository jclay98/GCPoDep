class InvestigationNotesController < ApplicationController
  
  def new
  	@investigation_note = InvestigationNote.new
    @investigation = Investigation.find(params[:investigation_id])
    render action: 'new', locals: { investigation: @investigation}

  end

  def create
    @investigation_note = InvestigationNote.new(investigation_note_params)
    @investigation_note.officer_id = current_user.officer.id
    @investigation_note.date = Date.current
    if @investigation_note.save
      flash[:notice] = "Successfully created investigation note."
      redirect_to investigation_path(@investigation_note.investigation)
    else
      @investigation = Investigation.find(params[:investigation_note][:investigation_id])
      render action: 'new', locals: { investigation: @investigation}
    end
  end

  def destroy
  	@investigation = Investigation.find(params[:id])
    @investigation_note = InvestigationNote.find(params[:id])
    if @investigation_note.destroy
      redirect_to investigation_path(@investigation), notice: "Successfully removed #{@investigation_note} from the GCPD system."
    else
      @investigation_note = InvestigationNote.find(params[:id])
      render action: 'show'
    end
  end

  private
  	def investigation_note_params
  	  params.require(:investigation_note).permit(:investigation_id, :officer_id, :content, :date) 
    end
end
