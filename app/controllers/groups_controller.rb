class GroupsController < ApplicationController

  def new
    @group =Group.new
    @group.users << current_user
  end
  def create
    if @group = Group.create(group_params)
      redirect_to groups_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @groups = Group.all.order(updated_at: :desc)
  end

  def show
    @group = Group.find(params[:id])
    @group_owner = User.find(@group.owner_id)
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if current_user.id == @group.owner_id
      if @group.update(group_params)
        redirect_to groups_path
      else
        redirect_back(fallback_location: root_path)
      end
    end
  end
  private
  def group_params
    params.require(:group).permit(:image, :name, :introduction, :owner_id)
  end
end
