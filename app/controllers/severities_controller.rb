class SeveritiesController < ApplicationController

  before_filter :require_administrative_privileges

  def index
    @severities = Severity.order('id asc').all.paginate(:page => params[:page], :per_page => User.current_user.per_page_count)
  end

  def new
    @severity = Severity.new
  end

  def create
    @severity = Severity.create(params[:severity])
    if @severity.save
      redirect_to severities_path, :notice => 'Severity Created Successfully.'
    else
      render :action => 'new', :notice => 'Error: Unable To Create Record.'
    end
  end

  def update
    @severity = Severity.find(params[:id])
    if @severity.update_attributes(params[:severity])
      redirect_to severities_path, :notice => 'Severity Updated Successfully.'
    else
      render :action => 'edit', :notice => 'Error: Unable To Save Record.'
    end
  end

  def edit
    @severity = Severity.find(params[:id])
  end

  def destroy
    @severity = Severity.find(params[:id])
    @severity.destroy
    redirect_to severities_path, :notice => 'Severity Removed Successfully.'
  end

end
