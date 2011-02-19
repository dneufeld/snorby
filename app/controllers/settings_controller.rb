class SettingsController < ApplicationController

  before_filter :require_administrative_privileges

  def index
    @settings = Setting.first
  end

  def update
    @settings = Setting.first
    @settings.update_attributes(params[:setting])
    redirect_to settings_path, :notice => 'Settings Updated Successfully.'
  end

  def start_worker
    Snorby::Worker.start unless Snorby::Worker.running?
    redirect_to jobs_path
  end

  def start_sensor_cache
    Snorby::Jobs.sensor_cache.destroy! if Snorby::Jobs.sensor_cache?
    Delayed::Job.enqueue(Snorby::Jobs::SensorCacheJob.new(false), :priority => 1)
    redirect_to jobs_path
  end

  def start_daily_cache
    Snorby::Jobs.daily_cache.destroy! if Snorby::Jobs.daily_cache?
    Delayed::Job.enqueue(Snorby::Jobs::DailyCacheJob.new(false), :priority => 1, :run_at => Time.now.tomorrow.beginning_of_day)
    redirect_to jobs_path
  end

  def restart_worker
    Snorby::Worker.restart if Snorby::Worker.running?
    redirect_to jobs_path
  end

end
