module PeopleImport

  def self.createLocation(name, person)
    @location = Location.new
    @location.attributes = {name: name, person: person}
    @location
  end

  def self.createAffiliation(name, person)
    @affiliation = Affiliation.new
    @affiliation.attributes = {name: name, person: person}
    @affiliation
  end

  def self.createPeople(first_name, last_name, gender, species, weapon, vehicle)
    @person = Person.new
    @person.first_name = first_name
    @person.last_name = last_name
    @person.weapon = weapon
    @person.gender = gender
    @person.vehicle = vehicle
    @person.species = species
    @person
  end
end
