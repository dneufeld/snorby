class SensorsController < ApplicationController

  before_filter :require_administrative_privileges, :except => [:index, :update_name]
  
  def index
    @sensors ||= Sensor.all.page(params[:page].to_i, :per_page => @current_user.per_page_count, :order => [:sid.asc])
  end
  
  def update_name
    @sensor = Sensor.get(params[:id])
    @sensor.update!(:name => params[:name]) if @sensor
    render :text => @sensor.name
  end

end
