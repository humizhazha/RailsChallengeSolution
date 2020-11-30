require 'csv'
require_relative "../services/people_import"

class PageController < ApplicationController
  include PeopleImport

  def importToDatabase
    file_data = params[:file]
    if file_data.respond_to?(:path)
      @table = CSV.parse(File.read(file_data.path), headers: true)
      @table.each do |row|
        if !row["Affiliations"].present?
          next
        end
        full_name = row["Name"].split(' ', 2)
        first_name = full_name[0]
        last_name = full_name[1]
        @person = createPeople(first_name, last_name, row["Gender"], row["Species"], row["Weapon"], row["Vehicle"])
        @person.save
        @location = createLocation(row["Location"], @person)
        @location.save
        @affiliation = createAffiliation(row["Affiliations"], @person)
        @affiliation.save
      end
      redirect_to people_path, notice: "Successfully import file to database!"
    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
      redirect_to people_path, alert: "File Invalid"
    end

  end

end
