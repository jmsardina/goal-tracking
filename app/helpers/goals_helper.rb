module GoalsHelper
  def li_for_goal(goal)
    content_tag :li, :"data-goal-id" => goal.id, class: (goal.complete? ? "completed" : "") do
      yield
    end
  end

end
