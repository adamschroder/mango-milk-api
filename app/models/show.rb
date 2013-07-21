class Show < ActiveRecord::Base

  def self.search(search)
  if search
    #[ "lower(name) = ?", name.downcase ]
    down_case_term = search.downcase
    find(:all, :conditions => ['lower(title) LIKE ?', "%#{down_case_term}%"])
  else
    find(:all)
  end
end
end
