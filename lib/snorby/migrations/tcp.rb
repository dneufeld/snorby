module Snorby
  module Migrations
    class Tcp
      include DataMapper::Resource

      storage_names[:default] = "tcphdr"

      property :sid, Integer, :key => true, :index => true

      property :cid, Integer, :key => true, :index => true

      property :tcp_sport, Integer, :index => true

      property :tcp_dport, Integer, :index => true

      property :tcp_seq, Integer

      property :tcp_ack, Integer

      property :tcp_off, Integer

      property :tcp_res, Integer

      property :tcp_flags, Integer

      property :tcp_win, Integer

      property :tcp_csum, Integer

      property :tcp_urp, Integer

    end
  end
end
