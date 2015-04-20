
NAMES = ["Chris", "Skylar", "Jennifer", "Cyrus", "John"]

GROUP_NAMES = ["Group 1", "Group 2", "Group 3", "Group 4"]
GROUP_DESCRIPTIONS = ["At work, we accomplish all kinds of things; we are extending that to other parts of our lives now.", "Ever since college, we have been supporting each other in all kinds of things - now we can be organized about it!", "We just wanna have fun! And achieve SMART goals. That sounds fun!!!", "Work hard. Play hard. Goal hard."]

TAGS = ["health", "spiritual", "finance", "education", "personal", "relationship", "work", "political", "weight-loss"]

def create_tags
  TAGS.each{|tag| Tag.create(name: tag)}
end

create_tags

def create_groups
	group = Group.create(
		name: GROUP_NAMES.sample, 
		description: GROUP_DESCRIPTIONS.sample,
		creator_id: User.all.sample.id)
	rand(TAGS.length).times {group.tag_ids << Tag.all.sample.id}
	rand(User.all.length).times {group.members << User.all.sample}
	group.save
end

def emails
	emails = []
	base_string = "person_0@example.com"
	(1..20).each do |number|
		emails << base_string.gsub("0", number.to_s)
	end
	emails
end

EMAILS = emails

def lang_goal 
	Goal.create(
		name: "French", 
		description: "Become conversationally proficient in French in 6 months", 
		due_date: 90.days.from_now, 
		motivation: "I'm traveling to France in November", 
		potential_barrier: "I don't know how I'll find the time", 
		coping_strategy: "Using Goaly!",
		support: "My friend so-and-so is learning with me.")
end

def lang_activities 
	Activity.create([
		{description: "Practice Duolingo", 
			period: "day", 
			barrier: "I feel like I don't have time.", 
			facilitator: "Jennifer will always be there cheering me on!",
			frequency: 1}, 
		{description: "Have a conversation with a native speaker", 
			period: "month", 
			barrier: "I'm shy", 
			facilitator: "I'm friendly",
			frequency: 2}, 
		{description: "Watch foreign-language TV", 
			period: "week", 
			barrier: "The weather is getting nice and I might not want to watch TV.", 
			facilitator: "???", 
			frequency: 1}, 
			{description: "Read in the langauge", 
				period: "week", 
				barrier: "", 
				facilitator: "", 
				frequency: 2}])
end

def exercise_goal 
	Goal.create(
		name: "Exercise", 
		description: "Exercise 3x/week for the next 3 months", 
		due_date: 60.days.from_now, 
		motivation: "I want to go hiking this summer", 
		potential_barrier: "I don't know how I'll find the time", 
		coping_strategy: "Using Goaly!",
		support: "My friend so-and-so is doing this with me.")
end

def exercise_activities 
	Activity.create([
		{description: "Do yoga", 
			period: "week", 
			barrier: "I feel like I don't have time.", 
			facilitator: "Jennifer will always be there cheering me on!", 
			frequency: 3},
		{description: "Go for a walk outside", 
			period: "week", 
			barrier: "It's very rainy", 
			facilitator: "I can ask a friend to come with.", 
			frequency: 7},
		{description: "Do strength-training in the gym", 
			period: "week", 
			barrier: "I don't like strength-training that much.", 
			facilitator: "???", 
			frequency: 4}])
end

def create_users
	index = 0
	while index < EMAILS.length
		user = User.create(name: NAMES.sample, email: EMAILS[index], password: "password123")

		user.goals << lang_goal
		user.goals << exercise_goal


		user.goals.find_by(:name => "Exercise").activities << exercise_activities
		user.goals.find_by(:name => "French").activities << lang_activities
		
		user.save
		index += 1
	end
end

create_users

15.times {create_groups}