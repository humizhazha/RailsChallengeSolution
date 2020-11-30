require "prawn"
class PeopleController < ApplicationController

  def index
    @people = Person.order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 10)
    @all_people = Person.order(sort_column + " " + sort_direction)
    sort_and_filter
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text " Full_Name Gender Vehicle Weapon Species"
        pdf.move_down(5)
        @all_people.each do |row|
          pdf.text " #{row.full_name} #{row.gender} #{row.vehicle} #{row.weapon} #{row.species}"
          pdf.move_down(5)
        end
        send_data pdf.render, type: "application/pdf", disposition: "inline"
      end
      format.xlsx{
        response.headers['Content-Disposition'] = 'attachment; filename="all_people.xlsx"'
      }
    end
  end

  def new
    @person = Person.new
    @gender_list = Gender.list
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      session[:user_id] = @person.id
      flash[:success] = "Successfully added new #{@person.full_name}"
      redirect_to people_path
    else
      render 'new'
    end
  end

  def edit
    @gender_list = Gender.list
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(person_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to people_path
    else
      render 'edit'
    end
  end

  # def show
  #   @person = Person.order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: PAGE_NUM)
  #   sort_and_filter
  # end

  def sort_and_filter
    @people = Person.search(params[:search]) if params[:search].present?
    @people = @people.order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 10)
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    flash[:danger] = "This person have been deleted"
    redirect_to people_path
  end

  private
    def person_params
      params.require(:person).permit(:first_name, :last_name, :weapon, :gender, :vehicle, :species)
    end
end

