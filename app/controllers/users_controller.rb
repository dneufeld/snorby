class UsersController < ApplicationController

  before_filter :require_administrative_privileges, :only => [:index, :add, :new, :remove]
  
  def index
    @users = User.order('id asc').all.paginate(:page => params[:page], :per_page => User.current_user.per_page_count)
  end

  def new
    @user = User.new
  end
  
  def create
    
  end
  
  def add
    @user = User.create(params[:user])
    if @user.save
      redirect_to users_path
    else
      render :action => 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      render :json => {:success => 'User updated successfully.'}
    else
      render :json => {:error => 'Error while changing user attributes.'}
    end
  end
  
  def remove
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, :notice => "User successfully deleted"
  end

  def toggle_settings
    @user = User.find(params[:user_id])
    
    if @user.update_attributes(params[:user])
      render :json => {:success => 'User updated successfully.'}
    else
      render :json => {:error => 'Error while changing user attributes.'}
    end
    
  end

end
