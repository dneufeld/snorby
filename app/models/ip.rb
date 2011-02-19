class Ip < ActiveRecord::Base

  set_table_name "iphdr"
  
  set_primary_keys :sid, :cid
  
  belongs_to :sensor, :foreign_key => [:sid]
  
  belongs_to :event, :dependent => :destroy, :foreign_key => [:sid, :cid]

  def src
    convert_to_ip_object(ip_src)
  end
  
  def dst
    convert_to_ip_object(ip_dst)
  end

  private
  
  def convert_to_ip_object(ip)
    case ip
    when nil, 0
      nil
    else
      ::IPAddr.new(ip,Socket::AF_INET)
    end
  end

end
