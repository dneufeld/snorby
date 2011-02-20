class Setting < ActiveRecord::Base
  
  def self.method_missing(method, *args, &block)
    raise('Error - Missing Snorby Settings Table.') if Setting.all.blank?
    Setting.first.send(method.to_sym, *args, &block) if Setting.first.respond_to?(method.to_sym)
  end  
  
end
