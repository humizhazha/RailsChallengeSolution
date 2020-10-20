require 'csv'
class PageController < ApplicationController
  def home
    @person = Person.order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 10)
    sort_and_filter
  end

  def sort_and_filter
    @person = @person.where("first_name LIKE ?", "%#{params[:search]}%") if params[:search].present?
    @person = @person.order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 10)
  end

  def createLocation(name,person)
    @location = Location.new
    @location.attributes = {name: name, person: person}
    if @location.save
      @location
    else
      flash[:notice] = "Error in saving location "+name
    end
  end

  def createAffiliation(name,person)
    @affiliation = Affiliation.new
    @affiliation.attributes = {name: name, person: person}
    if @affiliation.save
      @affiliation
    else
      flash[:notice] = "Error in saving affiliation "+name
    end
  end

  def createPeople(first_name,last_name,gender,species,weapon,vehicle)
    @people = Person.new
    @people.first_name = first_name
    @people.last_name = last_name
    @people.weapon = weapon
    @people.gender = gender
    @people.vehicle = vehicle
    @people.species = species
    if @people.save
      @people
    else
      flash[:notice] = "Error in saving person "+first_name
    end
  end


  def importToDatabase
    file_data = params[:file]
    if file_data.respond_to?(:path)
      @table = CSV.parse(File.read(file_data.path), headers: true)
      @table.each do |row|
        if !row["Affiliations"].present?
          next
        end
        full_name = row["Name"].split(' ',2)
        first_name = full_name[0]
        last_name = full_name[1]
        @person = createPeople(first_name,last_name,row["Gender"],row["Species"],row["Weapon"],row["Vehicle"])
        @location = createLocation(row["Location"],@person)
        @affiliation = createAffiliation(row["Affiliations"],@person)
      end
      redirect_to root_path, notice: "Successfully import file to database!"

    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
      redirect_to root_path, alert: "File Invalid"
    end

  end

end
