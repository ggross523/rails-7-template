# == Schema Information
#
# Table name: course_evaluations
#
#  id                  :bigint           not null, primary key
#  avg_hours_prep      :float
#  clarity_mean        :float
#  course_name         :string
#  course_section      :string
#  course_title        :string
#  first_name          :string
#  interest_mean       :float
#  invited_count       :integer
#  last_name           :string
#  recommendation_mean :float
#  respondent_count    :integer
#  response_ratio      :float
#  term                :string
#  tools_insights_mean :float
#  value_mean          :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class CourseEvaluation < ApplicationRecord
  validates :course_name, :course_title, :first_name, :last_name, presence: true
  
  
  validates :clarity_mean, :interest_mean, :tools_insights_mean, 
            :value_mean, :recommendation_mean,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5, allow_nil: true }
            
 
end
