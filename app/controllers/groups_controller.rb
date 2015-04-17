class GroupsController < ApplicationController

	def index
		# if current_user
		# 	@groups = current_user.groups
		# else
		# 	@groups = Group.all
		# 	render 'welcome_page'
		# end
	end

	def new
		@group = Group.new
	end

	def create
  # binding.pry
		@group = Group.new(group_params)
		@group.creator_id = current_user.id
		if @group.save
			UserGroup.create(group_id: @group.id, member_id: current_user.id)
			track_feed(@group)
			redirect_to group_path(@group)
		else
			flash[:notice] = "Something went wrong...Try again."
			render :new
		end
	end

	def edit
		set_group
	end

	def update
		set_group.update(group_params)
		if @group.save
			redirect_to group_path(@group)
		else
			flash[:notice] = "Something went wrong... Try again."
			render :new
		end
	end


	def show
		set_group
		@comment = Comment.new
		@comments = Comment.where(commentable_type: "Group", commentable_id: set_group.id)
		# binding.pry
		@board = Board.new
		@boards = Board.where(group_id: set_group.id)
		@cheer = Cheer.new
		@members = @group.members
		@tags = @group.tags
		@invitation = Invitation.new
	end

	def destroy
		set_group.destroy
	end

	private
		def set_group
			@group = Group.find(params[:id])
		end

		def group_params
			params.require(:group).permit(:name, :description, :creator_id, :avatar, tag_ids: [])
		end
end
