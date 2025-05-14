# app/controllers/course_evaluations_controller.rb
class CourseEvaluationsController < ApplicationController
  def index
    @evaluations = CourseEvaluation.all
  end
  
  def import
    # Shows the upload form
  end
  
  def upload
    if params[:file].present? && params[:file].content_type == 'text/csv'
      counter = 0
      
      CSV.foreach(params[:file].path, headers: true) do |row|
        response_ratio = row['%ResponseRatio'].present? ? row['%ResponseRatio'].to_f : nil
        
        CourseEvaluation.create!(
          course_name: row['Course Name'],
          course_section: row['Course Section'],
          course_title: row['Course Title'],
          first_name: row['First Name'],
          last_name: row['Last Name'],
          term: row['Term'],
          invited_count: row['InvitedCount'],
          respondent_count: row['RespondentCount'],
          response_ratio: response_ratio,
          avg_hours_prep: row['Excluding class sessions, estimate the average number of hours per week spent in preparation or review. - Mean'],
          clarity_mean: row['Overall, did the instructor convey the course material clearly? - Mean'],
          interest_mean: row['Overall, did the instructor convey the course material in an interesting way? - Mean'],
          tools_insights_mean: row['Did you take away useful tools, concepts, and/or insights from this course? - Mean'],
          value_mean: row['How much did you get out of this course? - Mean'],
          recommendation_mean: row['Would you recommend this course to other students? - Mean']
        )
        counter += 1
      end
      
      redirect_to course_evaluations_path, notice: "Successfully imported #{counter} course evaluations."
    else
      redirect_to import_course_evaluations_path, alert: "Please upload a valid CSV file."
    end
  rescue => e
    redirect_to import_course_evaluations_path, alert: "Error: #{e.message}"
  end
end
