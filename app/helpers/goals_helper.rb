module GoalsHelper
  def li_for_goal(goal)
    content_tag :li, :"data-goal-id" => goal.id, class: (goal.complete? ? "completed" : "") do
      yield
    end
  end


#   def activities_array
#      Goal.all.collect { |goal| goal.activities.count}
#   end

#   def total_goal_activity_occurence
#   	sum = 0
#   	Goal.all.each do |goal|
#   	 sum +=	goal.total_remaining_occurence
#     end
#     sum
#   end

#   def total_remaining_goal_activity_occurence
#     sum = 0
#     Goal.all.each do |goal|
#       sum += goal.total_activity_occurence
#     end
#     sum
#   end

#   def completed_activities
#     total_remaining_goal_activity_occurence - total_goal_activity_occurence
#   end

#   def overall_percentage_complete

#     ((completed_activities / total_remaining_goal_activity_occurence.to_f) * 100).round(1)
#   end

end
