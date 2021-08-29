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
    @groupmenbers = @group.users

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

  def groupcreate
    if groupuser = GroupUser.create(user_id: current_user.id , group_id: params[:group_id])
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def groupdestroy
    group_user = GroupUser.find_by(user_id: current_user.id ,group_id: params[:group_id] )
    if group_user.destroy
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def mail_new
    @group = Group.find(params[:group_id])
  end
  
  def mail_send
    @group = Group.find(params[:group_id])
    group_users = @group.users
    @mail_title = params[:mail_title]
    @mail_content = params[:mail_content]
    ContactMailer.send_mail(@mail_title, @mail_content, group_users).deliver
  end
  
  private
  def group_params
    params.require(:group).permit(:image, :name, :introduction, :owner_id)
  end
end
