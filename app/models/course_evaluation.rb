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
  # Explicitly define the course_title attribute
  attribute :course_title, :string
  
  # Add this line
  attribute :course_title, :string
  
  # Validations
  validates :course_name, :course_title, presence: true
  
  # Scope for highly-rated courses
  scope :highly_rated, -> { where("recommendation_mean >= ?", 4.5) }
  
  # Helper method to get full instructor name
  def instructor_name
    "#{first_name} #{last_name}"
  end
  
  # Format response ratio as percentage
  def response_rate_percentage
    return nil if response_ratio.nil?
    "#{(response_ratio * 100).round(1)}%"
  end
end
