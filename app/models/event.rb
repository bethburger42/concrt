class Event < ActiveRecord::Base
  has_and_belongs_to_many :users

  # validates :datepicker_start_date, :datepicker_end_date, presence: true

end
