class GroupsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all.where(['group_code LIKE ?', "%#{params[:search]}%"]).paginate(page: params[:page])
    @teacher = User.in_group(@group).as('teacher')



  end

  def new
    @group = Group.new
    #logged_in?
    #current_user

  end

  def show
    @teacher = User.in_group(@group).as('teacher')
    @users = @group.users
  end

  def edit
    @group   = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(user_params)
      flash[:success] = "Profil zaktualizowany"
      redirect_to @group
    else
      render 'edit'
    end
  end


  def create
    @group = Group.new(group_params)
    #user = User.find_by_id(1)
    if @group.save

      @group.add(current_user, as: 'teacher')
      flash[:success] = "Grupa dodana"
      redirect_to groups_url
    else
      #puts "User id"
     # puts user.id
      render 'new'
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    flash[:success] = "Grupa usunięta"
    redirect_to groups_url
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:title, :description,:group_code)
  end
end
