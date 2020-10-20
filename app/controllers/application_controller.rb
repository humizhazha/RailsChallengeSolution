class ApplicationController < ActionController::Base
  helper_method :sort_column, :sort_direction

  def sort_column
    Person.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
