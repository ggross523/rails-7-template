# app/controllers/course_evaluations_controller.rb
# app/controllers/course_evaluations_controller.rb
class CourseEvaluationsController < ApplicationController
  def index
    # Initialize query
    @evaluations = CourseEvaluation.all
    
    # Apply search if parameter exists
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @evaluations = @evaluations.where(
        "course_name ILIKE ? OR course_title ILIKE ? OR first_name ILIKE ? OR last_name ILIKE ?", 
        search_term, search_term, search_term, search_term
      )
    end
    
    # Apply sorting: first by course_name ascending, then by term descending
    @evaluations = @evaluations.order(course_name: :asc, term: :desc)
  end
  
  def show
    @evaluation = CourseEvaluation.find(params[:id])
  end
  
  def search_instructor
    if params[:instructor].present?
      name_parts = params[:instructor].split
      
      if name_parts.size > 1
        # Search by both first and last name
        first_name = name_parts.first
        last_name = name_parts.last
        
        @evaluations = CourseEvaluation.where("first_name ILIKE ? AND last_name ILIKE ?", 
                                             "%#{first_name}%", "%#{last_name}%")
      else
        # Search by either first or last name
        @evaluations = CourseEvaluation.where("first_name ILIKE ? OR last_name ILIKE ?", 
                                             "%#{params[:instructor]}%", "%#{params[:instructor]}%")
      end
      
      # Apply the same sorting as the index page
      @evaluations = @evaluations.order(course_name: :asc, term: :desc)
    else
      # For the initial page load, get all unique instructors for the form
      @instructors = CourseEvaluation.select("DISTINCT first_name, last_name")
                                   .order("last_name, first_name")
    end
  end
  
  def compare
    if params[:course_ids].present?
      @evaluations = CourseEvaluation.where(id: params[:course_ids])
      
      # Calculate averages for chart data
      @chart_data = {
        labels: @evaluations.map { |e| e.course_title },
        clarity: @evaluations.map { |e| e.clarity_mean || 0 },
        interest: @evaluations.map { |e| e.interest_mean || 0 },
        tools: @evaluations.map { |e| e.tools_insights_mean || 0 },
        value: @evaluations.map { |e| e.value_mean || 0 },
        recommendation: @evaluations.map { |e| e.recommendation_mean || 0 }
      }
    else
      # For the initial page load, get courses for selection
      @courses = CourseEvaluation.select("id, course_name, course_title, first_name, last_name, term")
                               .order("course_title")
    end
  end
end
