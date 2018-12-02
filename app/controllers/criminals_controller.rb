class CriminalsController < ApplicationController
  before_action :check_login

  def index
    @criminals = Criminal.alphabetical.all.paginate(page: params[:page]).per_page(10)
    @felons = Criminal.prior_record.alphabetical.all.paginate(page: params[:page]).per_page(10)
    @powers = Criminal.enhanced.alphabetical.all.paginate(page: params[:page]).per_page(10)
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
    @criminal = criminal.find(params[:id])
    respond_to do |format|
      if @criminal.update_attributes(criminal_params)
        format.html { redirect_to @criminal, notice: "Updated information" }

      else
        format.html { render :action => "edit" }

      end
    end
  end



  private
  def criminal_params
    params.require(:criminal).permit(:first_name, :last_name, :aka, :convicted_felon, :enhanced_powers, :notes)
  end
end
