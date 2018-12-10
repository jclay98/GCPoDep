class CriminalsController < ApplicationController
  before_action :check_login

  def index
    @criminals = Criminal.alphabetical.all.paginate(page: params[:page]).per_page(15)
    @felons = Criminal.prior_record.alphabetical.all.to_a
    @powers = Criminal.enhanced.alphabetical.all.to_a
  end

  def show
  	@criminal = Criminal.find(params[:id])
    @current_suspects = @criminal.suspects.current
  	@investigations = @criminal.investigations.is_open.chronological
  end

  def new
    @criminal = Criminal.new
  end

  def edit
    @criminal = Criminal.find(params[:id])
  end

  def create
    @criminal = Criminal.new(criminal_params)
    if @criminal.save
      redirect_to criminals_path, notice: "Successfully added #{@criminal.name} to GCPD."
    else
      render action: 'new'
    end
  end

  def update
    @criminal = Criminal.find(params[:id])
    respond_to do |format|
      if @criminal.update_attributes(criminal_params)
        format.html { redirect_to @criminal, notice: "Updated information" }

      else
        format.html { render :action => "edit" }

      end
    end
  end

  def destroy
    @criminal = Criminal.find(params[:id])
    if @criminal.destroy
      redirect_to criminals_url, notice: "Successfully removed #{@criminal.name} from the GCPD system."
    else
      @criminal = Criminal.find(params[:id])
  	  @investigations = @criminal.investigations.current.chronological
      render action: 'show'
    end
  end




  private
  def criminal_params
    params.require(:criminal).permit(:first_name, :last_name, :aka, :convicted_felon, :enhanced_powers, :notes)
  end
end
