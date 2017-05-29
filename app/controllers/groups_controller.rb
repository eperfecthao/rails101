class GroupsController < ApplicationController

  before_action :find_group_and_check_permission, only: [ :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
      flash[:notice] = "新建成功"
    else
      render :new
    end
  end

  def edit

  end

  def update

    if @group.update(group_params)
      redirect_to groups_path
      flash[:notice] = "修改成功"
    else
      render :edit
    end
  end

  def destroy

    @group.destroy
    redirect_to groups_path
    flash[:warning] = "删除成功"
  end

  def join
    @group = Group.find(params[:id])
    current_user.join!(@group)
    flash[:notice] = "加入群组成功"
    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])
    current_user.quit!(@group)
    flash[:warning] = "退出群组成功"
    redirect_to group_path(@group)
  end

  private

  def find_group_and_check_permission
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path, alert: "you have no permission"
    end
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
