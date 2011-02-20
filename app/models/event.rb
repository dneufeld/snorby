class Event < ActiveRecord::Base
  set_table_name 'event'
  set_primary_keys :sid, :cid

  # Included for the truncate helper method.
  extend ActionView::Helpers::TextHelper

  belongs_to :classification, :counter_cache => true

  has_many :favorites, :foreign_key => [:sid, :cid], :dependent => :destroy

  has_many :users, :through => :favorites, :foreign_key => :user_id

  has_one :severity, :through => :signature

  has_one :payload, :dependent => :destroy, :foreign_key => [:sid, :cid]

  has_one :icmp, :dependent => :destroy, :foreign_key => [:sid, :cid]

  has_one :tcp, :dependent => :destroy, :foreign_key => [:sid, :cid]

  has_one :udp, :dependent => :destroy, :foreign_key => [:sid, :cid]

  has_one :opt, :dependent => :destroy, :foreign_key => [:sid, :cid]

  has_many :notes, :dependent => :destroy, :foreign_key => [:sid, :cid]

  belongs_to :user, :counter_cache => true

  belongs_to :sensor, :foreign_key => :sid

  belongs_to :signature, :class_name => "Signature", :foreign_key => :signature

  has_one :ip, :class_name => 'Ip', :foreign_key => [:sid, :cid], :dependent => :destroy

  def sig_id
    signature.sig_id
  end
  alias :signature_id :sig_id

  def packet_capture(params={})
    case Setting.packet_capture_type.to_sym
    when :openfpc
      Snorby::Plugins::OpenFPC.new(self,params).to_s
    when :solera
      Snorby::Plugins::Solera.new(self,params).to_s
    else
      nil
    end
  end

  def signature_url
    if Setting.signature_lookup?
      url = Setting.signature_lookup
      return url.sub(/\$\$sid\$\$/, signature.sig_sid.to_s).sub(/\$\$gid\$\$/, signature.sig_gid.to_s)
    else
      url = "http://rootedyour.com/snortsid?sid=$$gid$$-$$sid$$"
      return url.sub(/\$\$sid\$\$/, signature.sig_sid.to_s).sub(/\$\$gid\$\$/, signature.sig_gid.to_s)
    end
  end

  def matches_notification?
    Notification.each do |notify|
      next unless notify.sig_id == sig_id
      send_notification if notify.check(self)
    end
    nil
  end

  def send_notification
    Delayed::Job.enqueue(Snorby::Jobs::AlertNotifications.new(self.sid, self.cid))
  end

  def to_param
    "#{sid},#{cid}"
  end

  def self.last_month
    all(:timestamp.gte => 2.month.ago.beginning_of_month, :timestamp.lte => 1.month.ago.end_of_month)
  end

  def self.last_week
    all(:timestamp.gte => 2.week.ago.beginning_of_week, :timestamp.lte => 1.week.ago.end_of_week)
  end

  def self.yesterday
    all(:timestamp.gte => 1.day.ago.beginning_of_day, :timestamp.lte => 1.day.ago.end_of_day)
  end

  def self.today
    all(:timestamp.gte => Time.now.beginning_of_day, :timestamp.lte => Time.now.end_of_day)
  end

  def self.find_classification(classification_id)
    all(:classification_id => classification_id)
  end

  def self.find_signature(sig_id)
    all(:sig_id => sig_id)
  end

  def self.find_sensor(sensor)
    all(:sensor => sensor)
  end

  def self.between(start_time, end_time)
    all(:timestamp.gte => start_time, :timestamp.lte => end_time, :order => [:timestamp.desc])
  end

  def self.between_time(start_time, end_time)
    all(:timestamp.gte => start_time, :timestamp.lt => end_time, :order => [:timestamp.desc])
  end

  def self.find_by_ids(ids)
    events = []
    ids.split(',').collect do |e|
      event = e.split('-')
      events << get(event.first, event.last)
    end
    return events
  end

  def self.view_format(params={})
    view = (params[:view] || :all).to_sym

    case view
    when :unique
      Event.joins(:ip,:signature).group('ip_src, ip_dst, signature').where(:classification_id => nil)
    when :signature
      Event.joins(:ip,:signature).group('signature').where(:classification_id => nil)
    when :src
      Event.joins(:ip,:signature).group('ip_src').where(:classification_id => nil)
    when :dst
      Event.joins(:ip,:signature).group('ip_dst').where(:classification_id => nil)
    else
      Event.joins(:ip,:signature).where(:classification_id => nil)
    end
  end

  def html_id
    "event_#{sid}#{cid}"
  end

  def json_time
    "{time:'#{timestamp}'}"
  end

  def pretty_time
    return "#{timestamp.strftime('%l:%M %p')}" if Date.today.to_date == timestamp.to_date
    "#{timestamp.strftime('%m/%d/%Y')}"
  end

  #
  # To Json From Time Range
  #
  # This method will likely be deprecated
  # in favor of .to_json(:include). Due to
  # the snort schema being legacy this was
  # needed for the time being.
  #
  # @param [String] time Start timeåå
  #
  # @return [Hash] hash of events between range.
  #
  def self.to_json_since(time)
    events = Event.includes(:sensor, :ip, :signature).where('timestamp > ?', time).where(:classification_id => nil).order('timestamp DESC')
    json = {:events => []}
    events.each do |event|
      json[:events] << {
        :sid => event.sid,
        :cid => event.cid,
        :hostname => event.sensor.sensor_name,
        :severity => event.signature.sig_priority,
        :ip_src => event.ip.ip_src.to_s,
        :ip_dst => event.ip.ip_dst.to_s,
        :timestamp => event.pretty_time,
        :message => truncate(event.signature.name, :length => 65, :omission => '...')
      }
    end
    return json
  end

  def favorite?
    return true if User.current_user.events.all.include?(self)
    false
  end

  def toggle_favorite
    if self.favorite?
      destroy_favorite
    else
      create_favorite
    end
  end

  def create_favorite
    Favorite.create(:sid => sid, :cid => cid, :user => User.current_user)
  end

  def destroy_favorite
    favorite = self.favorites.where(:user_id => User.current_user).first
    favorite.destroy if favorite
  end

  def protocol
    if tcp?
      return :tcp
    elsif udp?
      return :udp
    elsif icmp?
      return :icmp
    else
      nil
    end
  end

  def protocol_data
    if tcp?
      return [:tcp, self.tcp]
    elsif udp?
      return [:udp, self.udp]
    elsif icmp?
      return [:icmp, self.icmp]
    else
      false
    end
  end

  def source_port
    if protocol_data.first == :icmp
      nil
    else
      protocol_data.last.send(:"#{protocol_data.first}_sport")
    end
  end

  def destination_port
    if protocol_data.first == :icmp
      nil
    else
      protocol_data.last.send(:"#{protocol_data.first}_dport")
    end
  end

  def in_xml
    %{
      <snorby>#{to_xml}#{user.to_xml if user}#{ip.to_xml}#{protocol_data.last.to_xml if protocol_data}#{classification.to_xml if classification}#{payload.to_xml if payload}#{notes.to_xml}</snorby>
    }
  end

  def in_json
    type, proto = protocol_data
    json = {
      :sid => sid,
      :cid => cid,
      :ip => ip,
      :src_ip => ip.ip_src.to_s,
      :src_port => src_port,
      :dst_ip => ip.ip_dst.to_s,
      :dst_port => dst_port,
      :type => type,
      :proto => proto,
      :payload => payload.to_ascii,
      :payload_html => payload.to_html
    }
    return json
  end

  #
  # ICMP
  #
  # @return [Boolean] return true
  # if the event proto was icmp.
  #
  def icmp?
    return true unless icmp.blank?
    false
  end

  #
  # TCP
  #
  # @retrun [Boolean] return true
  # if the event proto is tcp.
  #
  def tcp?
    return true unless tcp.blank?
    false
  end

  #
  # UDP
  #
  # @return [Boolean] return true
  # if the event proto is udp.
  #
  def udp?
    return true unless udp.blank?
    false
  end

  #
  # Event Source Port
  #
  # @return [Boolean] return the source
  # port for the event if available.
  #
  def src_port
    if icmp?
      return 0
    elsif tcp?
      return tcp.tcp_sport
    else
      return udp.udp_sport
    end
  end

  #
  # Event Destination Port
  #
  # @return [Boolean] return the sestination
  # port for the event if available.
  #
  def dst_port
    if icmp?
      return 0
    elsif tcp?
      return tcp.tcp_dport
    else
      return udp.udp_dport
    end
  end

  def self.reset_classifications
    all.update(:classification_id => 0)
    Classification.all.each do |classification|
      classification.update(:events_count => 0)
    end
  end

  def self.classify_from_collection(collection, classification, user, reclassify=false)
    @classification = Classification.get(classification)
    @user ||= User.get(user)

    collection.each do |event|
      next unless event
      old_classification = event.classification || false

      next if old_classification == @classification

      next if (old_classification && reclassify == false)

      event.user = @user

      if @classification.blank?
        event.classification = nil
      else
        event.classification = @classification
      end

      if event.save
        @classification.up(:events_count) if @classification
        old_classification.down(:events_count) if old_classification
      else
        Rails.logger.info "ERROR: #{event.errors.inspect}"
      end

    end
  end

  def self.search(params)
    # ...
  end

end
