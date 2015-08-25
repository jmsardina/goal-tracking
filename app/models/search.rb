class Search

  def self.for(search)
    results = []
    search_condition = "%#{search}%"
    results << User.where('name LIKE ? OR email LIKE ?', search_condition, search_condition)
    results << Group.where('name LIKE ?', search_condition)
    Group.all.each do |group|
      results << group if group.tags.include?(Tag.find_by(name: search))
    end
    results
  end
 
end