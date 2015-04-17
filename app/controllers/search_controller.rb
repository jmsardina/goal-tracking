class SearchController < ApplicationController
  # def index
  #   binding.pry
  #   @results = User.where(name: @result.name.include?(params[:keyword]))

  #   if @result
  #     # redirect_to
  #   # elsif !Search.for(params[:keyword]).empty?
  #     @results = Search.for(params[:keyword])
  #   else
  #     flash[:notice] = "No results match your search..."
  #     # redirect_to root_path
  #   end
  # end

  # def show
  # end

  # def search
  # end

  def create
    @results = Search.for(params["keyword"])
    @users = User.where('name like ? OR email like ?', params['keyword'], params['keyword'])

    # if @results.empty?
    #   flash[:notice] = "No results match your search..."
    #   # redirect_to root_path
    # else
    @group = Group.find(params[:group_id].to_i)
    @invitation = Invitation.new
      # @user_group = UserGroup.new
    @users = @results[0]
    @groups = @results[1..-1]
    render :results
    # end
  end

end