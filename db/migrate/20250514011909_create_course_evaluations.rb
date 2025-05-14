class CreateCourseEvaluations < ActiveRecord::Migration[7.1]
  def change
    create_table :course_evaluations do |t|
      t.string :course_name
      t.string :course_section
      t.string :course_title
      t.string :first_name
      t.string :last_name
      t.string :term
      t.integer :invited_count
      t.integer :respondent_count
      t.float :response_ratio
      t.float :avg_hours_prep
      t.float :clarity_mean
      t.float :interest_mean
      t.float :tools_insights_mean
      t.float :value_mean
      t.float :recommendation_mean

      t.timestamps
    end
  end
end
