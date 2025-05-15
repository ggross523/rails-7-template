# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    # Fetch statistics for dashboard
    @total_courses = CourseEvaluation.distinct.count(:course_name)
    @total_instructors = CourseEvaluation.distinct.count("first_name, last_name")
    @total_evaluations = CourseEvaluation.count
    
    # Top rated courses
    @top_courses = CourseEvaluation.order(recommendation_mean: :desc).limit(5)
    
    # Recent evaluations
    @recent_evaluations = CourseEvaluation.order(created_at: :desc).limit(5)
    
    # Average ratings
    @avg_clarity = CourseEvaluation.average(:clarity_mean)
    @avg_interest = CourseEvaluation.average(:interest_mean)
    @avg_tools = CourseEvaluation.average(:tools_insights_mean)
    @avg_value = CourseEvaluation.average(:value_mean)
    @avg_recommend = CourseEvaluation.average(:recommendation_mean)
  end
end
