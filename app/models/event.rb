class Event < ActiveRecord::Base
  has_and_belongs_to_many :users

  validate :end_after_start
  validates :datepicker_start_date, :datepicker_end_date, presence: true

  def end_after_start
    if :datepicker_end_date < :datepicker_start_date
      errors.add(:datepicker_end_date, "must be after the start date") 
    end 
  end
end
