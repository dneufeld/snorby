class SensorsController < ApplicationController

  before_filter :require_administrative_privileges, :except => [:index]

  def index
    @sensors ||= Sensor.order('sid asc').all.paginate(:page => params[:page], :per_page => User.current_user.per_page_count)
  end
  
  def update_name
    @sensor = Sensor.find(params[:id])
    @sensor.update_attributes(:name => params[:name]) if @sensor
    render :text => @sensor.name
  end

end
