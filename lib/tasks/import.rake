namespace :import do
  desc "Import Booth MBA Course Evaluations from CSV"
  task course_evaluations: :environment do
    require 'csv'
    
    filename = Rails.root.join('data', 'Booth_MBA_Course_Evaluation.csv')
    counter = 0
    
    CSV.foreach(filename, headers: true) do |row|
      # Convert percentage string to float if present
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
    
    puts "Imported #{counter} course evaluations successfully!"
  end
end
