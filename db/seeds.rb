# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
  # cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
  # Mayor.create(name: 'Emanuel', city: cities.first)

NAMES = ["Chris", "Skylar", "Jennifer", "Cyrus", "John"]
GROUP_NAMES = ["Group 1", "Group 2", "Group 3", "Group 4"]

def emails
  emails = []
  base_string = "person_0@example.com"
  (1..20).each do |number|
    emails << base_string.gsub("0", number.to_s)
  end
  emails
end

EMAILS = emails

lang_goal = Goal.create(name: "French", description: "Become conversationally proficient in French in 6 months", due_date: "Thu, 15 Oct 2015".to_date, motivation: "I'm traveling to France in November", potential_barrier: "I don't know how I'll find the time", coping_strategy: "Using Goaly!", support: "My friend so-and-so is learning with me.", activities: Activity.create([{description: "Practice Duolingo", period: "daily", barrier: "I feel like I don't have time.", facilitator: "Jennifer will always be there cheering me on!"}, {description: "Have a conversation with a native speaker", period: "monthly", barrier: "I'm shy", facilitator: "I'm friendly", frequency: 2}, {description: "Watch foreign-language TV", period: "weekly", barrier: "The weather is getting nice and I might not want to watch TV.", facilitator: "???", frequency: 1}, {description: "Read in the langauge", period: "weekly", barrier: "", facilitator: "", frequency: 2}]))

exercise_goal = Goal.create(name: "Exercise", description: "Exercise 3x/week for the next 3 months", due_date: "2015-07-15T".to_date, motivation: "I want to go hiking this summer", potential_barrier: "I don't know how I'll find the time", coping_strategy: "Using Goaly!", support: "My friend so-and-so is doing this with me.", activities: Activity.create([
  {description: "Do yoga", period: "weekly", barrier: "I feel like I don't have time.", facilitator: "Jennifer will always be there cheering me on!", frequency: 3},
  {description: "Go for a walk outside", period: "weekly", barrier: "It's very rainy", facilitator: "I can ask a friend to come with.", frequency: 7},
  {description: "Do strength-training in the gym", period: "weekly", barrier: "I don't like strength-training that much.", facilitator: "???", frequency: 4}]))

def create_users(lang_goal, exercise_goal)
  index = 0
  while index < EMAILS.length
    user = User.create(name: NAMES.sample, email: EMAILS[index], password: "password123", goals: [lang_goal, exercise_goal])
    index += 1
  end
end


create_users(lang_goal, exercise_goal)


# def create_groups
#   index = 0
#   while index < GROUP_NAMES.length
#     Group.create(name: GROUP_NAMES[index])
#     index += 1
#   end
# end

# create_groups

# def create_user_groups
#   UserGroup.create([
#     {user_id: 1, group_id: 1},
#     {user_id: 2, group_id: 2},
#     {user_id: 3, group_id: 3}]
#     )
# end

# create_user_groups


