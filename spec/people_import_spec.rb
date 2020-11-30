# require_relative "../app/services/people_import"
require 'rails_helper'

describe 'PeopleImport' do
  before do
    @person = Person.new
    @person.first_name = "Vivi"
    @person.last_name = "Hu"
  end
  describe ".createAffiliation" do
    context "create new affiliation" do
      it "successfully added" do
        expect(PeopleImport.createAffiliation("aff name",@person).name).to eq("aff name")
      end
    end
  end

end