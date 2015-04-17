module ActivitiesHelper

  def tr_for_activity(activity)
    content_tag :tr, :"data-activity-id" => activity.id, class: (activity.complete? ? "completed" : "") do
      yield 
    end
  end
end
