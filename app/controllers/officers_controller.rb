class OfficersController < ApplicationController
  before_action :set_officer, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
    @active_officers = Officer.active.alphabetical.paginate(page: params[:page]).per_page(10)
    @inactive_officers = Officer.inactive.alphabetical.paginate(page: params[:page]).per_page(10)
    #format.json { respond_with_bip(@active_officers) }
  end

  def show
    @current_assignments = @officer.assignments.current.chronological
    @past_assignments = @officer.assignments.past.chronological
  end

  def new
    @officer = Officer.new
  end

  def edit
  end

  def create
    @officer = Officer.new(officer_params)
    @user = User.new(user_params)
    @user.active = true
    unless current_user.role?(:commish)
      @user.role = "officer"
    end
    if !@user.save
      @officer.valid?
      render action: 'new'
    else
      @officer.user_id = @user.id
      if @officer.save
        flash[:notice] = "Successfully created #{@officer.proper_name}."
        redirect_to officer_path(@officer) 
      else
        render action: 'new'
      end  
    end    
  end

  def update
    respond_to do |format|
      if @officer.update_attributes(officer_params)
        format.html { redirect_to @officer, notice: "Successfully updated #{@officer.proper_name}" }
        format.json { respond_with_bip(@officer) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@officer) }
      end
    end
  end

  def destroy
    @officer = Officer.find(params[:id])
    if @officer.destroy
      redirect_to officers_url, notice: "Successfully removed #{@officer.name} from the GCPD system."
    else
      @officer = Officer.find(params[:id])
      @current_assignments = @officer.assignments.current.chronological
      @past_assignments = @officer.assignments.past.chronological
      render action: 'show'
    end
  end



  private
  # Use callbacks to share common setup or constraints between actions.
  def set_officer
    @officer = Officer.find(params[:id])
  end
  # Only allow the white list through.
  def officer_params
    params.require(:officer).permit(:first_name, :last_name, :rank, :ssn, :active, :unit_id)
  end
  def user_params
    params.require(:officer).permit(:username, :role, :password, :password_confirmation, :active)
  end

end
