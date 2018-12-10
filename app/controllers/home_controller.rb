class HomeController < ApplicationController
  def index
    if logged_in? && current_user.role?(:commish)
      commish_data
    elsif logged_in? && current_user.role?(:chief)
      chief_data
    elsif logged_in? && current_user.role?(:officer)  
      officer_data 
    else
      fred = fred
    end 
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def search
    redirect_back(fallback_location: home_path) if params[:query].blank?
    @query = params[:query]
    @criminals = Criminal.search(@query)
    @officers = Officer.search(@query)
    @investigations = Investigation.title_search(@query)
    @total_hits = @criminals.size + @officers.size + @investigations.size
  end

  private
    def commish_data
      @officer = current_user.officer
      @units = Unit.active.all.to_a
      @crimes = Crime.all.to_a
      @closed_unsolved = Investigation.is_closed.unsolved.chronological.to_a.reverse.take(5)
      @closed_solved = Investigation.is_closed.was_solved.chronological.to_a.reverse.take(5)


    end

    def chief_data
      @officer = current_user.officer
      @unit = @officer.unit
      @unit_officers = @unit.officers
      @unit_assignments = []
      @unit_officers.each do |officer|
        @unit_assignments.push(officer.assignments)
      end
      @unit_investigations = []

      @unit_assignments.each do |a| 
        #@unit_investigations.push(a.investigation)

      # @unit_officers.each do |o|
      #   @unit_investigations.push(o.assignments.investigations)
      end
      @unit_investigations.uniq!
      @unassigned_officers = [] 
      @unit_officers.each do |officer|
        if officer.assignments.current.empty?
          @unassigned_officers.push(officer)
        end
      end
      @unassigned_investigations = []
      # @unit_investigations.each do |investigation|
      #   if investigation.assignments.empty?
      #     @unassigned_investigations.push(investigation)
      #   end
      # end
    end

    def officer_data
      @officer = current_user.officer
      @unit = @officer.unit
      @notes = []
      @my_investigations = @officer.investigations.chronological
      @my_investigations.each do |investigation|
        @investigation = investigation
        @notes.push(investigation.investigation_notes)
      end
      @recent_notes = @notes.take(3)
      @recent_notes.flatten!
      #@criminal = Criminal.new

      #@officer = current_user.officer
      #params.require(:officer).permit(:first_name, :last_name, :rank, :ssn, :active, :unit_id)
    end

end
