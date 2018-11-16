class Ability
  include CanCan::Ability

  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user

    if user.role? :commish
      can :manage, :all

    elsif user.role? :chief
      can :read, :all
      can :manage, Investigation
      can :manage, InvestigationNote
      can :manage, CrimeInvestigation
      can :manage, Criminal
      can :manage, Suspect
      can :manage, Assignment

      can :read, Unit

      can :update, Unit do |unit|  
        unit.id == user.officer.unit_id
      end

      can :manage, Officer do |o|  
        o.unit_id == user.officer.unit_id
      end

    # they can read their own profile
      can :show, User do |u|  
        u.id == user.id
      end

      # they can update their own profile
      can :update, User do |u|  
        u.id == user.id
      end

    elsif user.role? :officer
      can :show, Officer do |this_officer|  
        user.officer == this_officer
      end
      
      can :manage, InvestigationNote
      can :manage, CrimeInvestigation
      can :manage, Criminal
      can :manage, Suspect

      can :read, Investigation
      can :read, Crime
      can :read, Assignment

      can :index, Unit

      can :new, Investigation
      can :create, Investigation

      can :update, Investigation do |this_inv| 
        #my_investigations = user.officer.investigations.select { |i| i.officer.user.id }
        #my_investigations.include? this_inv.id
      end

      can :show, Unit do |unit|  
        unit.id == user.officer.unit_id
      end

      can :read, Officer do |o|  
        o.id == user.officer.id
      end

      can :update, Officer do |o|  
        o.id == user.officer.id
      end

      can :read, User do |u|  
        u.id == user.id
      end

      can :update, User do |u|  
        u.id == user.id
      end


    else
      can :read, Crime
    end   
  end
end
