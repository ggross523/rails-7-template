# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    # Fetch statistics for dashboard
    @total_courses = CourseEvaluation.distinct.count(:course_name)
    
    # PostgreSQL-specific fix for counting distinct instructor combinations
    @total_instructors = CourseEvaluation.connection.select_value(
      "SELECT COUNT(*) FROM (SELECT DISTINCT first_name, last_name FROM course_evaluations) AS temp"
    )
    
    @total_evaluations = CourseEvaluation.count
    
    # Rest of your controller code...
    @top_courses = CourseEvaluation.order(recommendation_mean: :desc).limit(5)
    @recent_evaluations = CourseEvaluation.order(created_at: :desc).limit(5)
    @avg_clarity = CourseEvaluation.average(:clarity_mean)
    @avg_interest = CourseEvaluation.average(:interest_mean)
    @avg_tools = CourseEvaluation.average(:tools_insights_mean)
    @avg_value = CourseEvaluation.average(:value_mean)
    @avg_recommend = CourseEvaluation.average(:recommendation_mean)
  end
end
