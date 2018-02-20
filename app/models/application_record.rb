class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def zip_codes
    {"San Francisco" => 91407,
     "San Jose" => 95113,
     "Redwood City" => 94063,
     "Mountain View" => 94041,
     "Palo Alto" => 94301}
  end
end
