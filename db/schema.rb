# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110219213703) do

  create_table "caches", :force => true do |t|
    t.integer  "sid"
    t.integer  "cid"
    t.datetime "ran_at"
    t.integer  "event_count",       :default => 0
    t.integer  "tcp_count",         :default => 0
    t.integer  "udp_count",         :default => 0
    t.integer  "icmp_count",        :default => 0
    t.text     "severity_metrics"
    t.text     "signature_metrics"
    t.text     "src_ips"
    t.text     "dst_ips"
  end

  create_table "classifications", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "hotkey"
    t.boolean  "locked",       :default => false
    t.integer  "events_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "classifications", ["events_count"], :name => "index_classifications_on_events_count"
  add_index "classifications", ["hotkey"], :name => "index_classifications_on_hotkey"
  add_index "classifications", ["locked"], :name => "index_classifications_on_locked"

  create_table "daily_caches", :force => true do |t|
    t.integer  "sid"
    t.integer  "cid"
    t.datetime "ran_at"
    t.integer  "event_count",       :default => 0
    t.integer  "tcp_count",         :default => 0
    t.integer  "udp_count",         :default => 0
    t.integer  "icmp_count",        :default => 0
    t.text     "severity_metrics"
    t.text     "signature_metrics"
    t.text     "src_ips"
    t.text     "dst_ips"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "data", :id => false, :force => true do |t|
    t.integer "sid",          :null => false
    t.integer "cid",          :null => false
    t.text    "data_payload"
  end

  add_index "data", ["cid"], :name => "index_data_cid"
  add_index "data", ["sid"], :name => "index_data_sid"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.text     "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "detail", :primary_key => "detail_type", :force => true do |t|
    t.text "detail_text"
  end

  add_index "detail", ["detail_type"], :name => "index_detail_detail_type"

  create_table "encoding", :primary_key => "encoding_type", :force => true do |t|
    t.text "encoding_text"
  end

  add_index "encoding", ["encoding_type"], :name => "index_encoding_encoding_type"

  create_table "event", :id => false, :force => true do |t|
    t.integer  "sid",                              :null => false
    t.integer  "cid",                              :null => false
    t.integer  "signature"
    t.integer  "classification_id"
    t.integer  "users_count",       :default => 0
    t.integer  "user_id"
    t.integer  "notes_count",       :default => 0
    t.datetime "timestamp"
  end

  add_index "event", ["cid"], :name => "index_event_cid"
  add_index "event", ["classification_id"], :name => "index_event_classification_id"
  add_index "event", ["notes_count"], :name => "index_event_notes_count"
  add_index "event", ["sid"], :name => "index_event_sid"
  add_index "event", ["signature"], :name => "index_event_signature"
  add_index "event", ["user_id"], :name => "index_event_user_id"
  add_index "event", ["users_count"], :name => "index_event_users_count"

  create_table "favorites", :force => true do |t|
    t.integer "sid",     :null => false
    t.integer "cid",     :null => false
    t.integer "user_id", :null => false
  end

  add_index "favorites", ["cid"], :name => "index_favorites_cid"
  add_index "favorites", ["id"], :name => "index_favorites_id"
  add_index "favorites", ["sid"], :name => "index_favorites_sid"
  add_index "favorites", ["user_id"], :name => "index_favorites_user_id"

  create_table "icmphdr", :id => false, :force => true do |t|
    t.integer "sid",       :null => false
    t.integer "cid",       :null => false
    t.integer "icmp_type"
    t.integer "icmp_code"
    t.integer "icmp_csum"
    t.integer "icmp_id"
    t.integer "icmp_seq"
  end

  add_index "icmphdr", ["cid"], :name => "index_icmphdr_cid"
  add_index "icmphdr", ["sid"], :name => "index_icmphdr_sid"

  create_table "iphdr", :id => false, :force => true do |t|
    t.integer "sid",                     :null => false
    t.integer "cid",                     :null => false
    t.integer "ip_src",                  :null => false
    t.integer "ip_dst",                  :null => false
    t.integer "ip_ver",   :default => 0, :null => false
    t.integer "ip_hlen",  :default => 0, :null => false
    t.integer "ip_tos",   :default => 0, :null => false
    t.integer "ip_len",   :default => 0, :null => false
    t.integer "ip_id",    :default => 0, :null => false
    t.integer "ip_flags", :default => 0, :null => false
    t.integer "ip_off",   :default => 0, :null => false
    t.integer "ip_ttl",   :default => 0, :null => false
    t.integer "ip_proto", :default => 0, :null => false
    t.integer "ip_csum",  :default => 0, :null => false
  end

  add_index "iphdr", ["cid"], :name => "index_iphdr_cid"
  add_index "iphdr", ["ip_dst"], :name => "index_iphdr_ip_dst"
  add_index "iphdr", ["ip_src"], :name => "index_iphdr_ip_src"
  add_index "iphdr", ["sid"], :name => "index_iphdr_sid"

  create_table "notes", :force => true do |t|
    t.integer  "sid"
    t.integer  "cid"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "notes", ["cid"], :name => "index_notes_cid"
  add_index "notes", ["sid"], :name => "index_notes_sid"
  add_index "notes", ["user_id"], :name => "index_notes_user_id"

  create_table "notifications", :force => true do |t|
    t.text    "description"
    t.integer "sig_id"
    t.string  "ip_src"
    t.string  "ip_dst"
    t.integer "user_id"
    t.text    "user_ids"
    t.text    "sensor_ids"
  end

  create_table "opt", :id => false, :force => true do |t|
    t.integer "sid",       :null => false
    t.integer "cid",       :null => false
    t.integer "optid",     :null => false
    t.integer "opt_proto"
    t.integer "opt_code"
    t.integer "opt_len"
    t.text    "opt_data"
  end

  add_index "opt", ["cid"], :name => "index_opt_cid"
  add_index "opt", ["optid"], :name => "index_opt_optid"
  add_index "opt", ["sid"], :name => "index_opt_sid"

  create_table "reference", :primary_key => "ref_id", :force => true do |t|
    t.integer "ref_system_id"
    t.text    "ref_tag"
  end

  add_index "reference", ["ref_id"], :name => "index_reference_ref_id"

  create_table "reference_system", :primary_key => "ref_system_id", :force => true do |t|
    t.string "ref_system_name", :limit => 50
  end

  add_index "reference_system", ["ref_system_id"], :name => "index_reference_system_ref_system_id"

  create_table "schema", :force => true do |t|
    t.integer  "vseq"
    t.datetime "ctime"
    t.string   "version", :limit => 50
  end

  add_index "schema", ["id"], :name => "index_schema_id"

  create_table "sensor", :primary_key => "sid", :force => true do |t|
    t.string  "name",         :limit => 50, :default => "Click To Change Me"
    t.text    "hostname"
    t.text    "interface"
    t.text    "filter"
    t.integer "detail"
    t.integer "encoding"
    t.integer "last_cid"
    t.integer "events_count",               :default => 0
  end

  add_index "sensor", ["detail"], :name => "index_sensor_detail"
  add_index "sensor", ["encoding"], :name => "index_sensor_encoding"
  add_index "sensor", ["events_count"], :name => "index_sensor_events_count"
  add_index "sensor", ["last_cid"], :name => "index_sensor_last_cid"
  add_index "sensor", ["sid"], :name => "index_sensor_sid"

  create_table "settings", :force => true do |t|
    t.string  "company"
    t.string  "email"
    t.string  "signature_lookup"
    t.boolean "daily"
    t.boolean "weekly"
    t.boolean "monthly"
    t.boolean "lookups"
    t.boolean "notes"
    t.boolean "packet_capture"
    t.string  "packet_capture_url"
    t.string  "packet_capture_type"
    t.boolean "packet_capture_auto_auth"
    t.string  "packet_capture_user"
    t.string  "packet_capture_password"
  end

  create_table "severities", :force => true do |t|
    t.integer "sig_id"
    t.integer "events_count", :default => 0
    t.string  "name"
    t.string  "text_color",   :default => "#fff"
    t.string  "bg_color",     :default => "#ddd"
  end

  add_index "severities", ["bg_color"], :name => "index_severities_on_bg_color"
  add_index "severities", ["events_count"], :name => "index_severities_on_events_count"
  add_index "severities", ["sig_id"], :name => "index_severities_on_sig_id"
  add_index "severities", ["text_color"], :name => "index_severities_on_text_color"

  create_table "sig_class", :primary_key => "sig_class_id", :force => true do |t|
    t.string "sig_class_name", :limit => 50
  end

  add_index "sig_class", ["sig_class_id"], :name => "index_sig_class_sig_class_id"

  create_table "sig_reference", :id => false, :force => true do |t|
    t.integer "sig_id",  :null => false
    t.integer "ref_seq", :null => false
    t.integer "ref_id"
  end

  add_index "sig_reference", ["ref_seq"], :name => "index_sig_reference_ref_seq"
  add_index "sig_reference", ["sig_id"], :name => "index_sig_reference_sig_id"

  create_table "signature", :primary_key => "sig_id", :force => true do |t|
    t.integer "sig_class_id"
    t.text    "sig_name"
    t.integer "sig_priority"
    t.integer "sig_rev"
    t.integer "sig_sid"
    t.integer "sig_gid"
    t.integer "events_count", :default => 0
  end

  add_index "signature", ["events_count"], :name => "index_signature_events_count"
  add_index "signature", ["sig_class_id"], :name => "index_signature_sig_class_id"
  add_index "signature", ["sig_id"], :name => "index_signature_sig_id"
  add_index "signature", ["sig_priority"], :name => "index_signature_sig_priority"

  create_table "tcphdr", :id => false, :force => true do |t|
    t.integer "sid",       :null => false
    t.integer "cid",       :null => false
    t.integer "tcp_sport"
    t.integer "tcp_dport"
    t.integer "tcp_seq"
    t.integer "tcp_ack"
    t.integer "tcp_off"
    t.integer "tcp_res"
    t.integer "tcp_flags"
    t.integer "tcp_win"
    t.integer "tcp_csum"
    t.integer "tcp_urp"
  end

  add_index "tcphdr", ["cid"], :name => "index_tcphdr_cid"
  add_index "tcphdr", ["sid"], :name => "index_tcphdr_sid"
  add_index "tcphdr", ["tcp_dport"], :name => "index_tcphdr_tcp_dport"
  add_index "tcphdr", ["tcp_sport"], :name => "index_tcphdr_tcp_sport"

  create_table "udphdr", :id => false, :force => true do |t|
    t.integer "sid",       :null => false
    t.integer "cid",       :null => false
    t.integer "udp_sport"
    t.integer "udp_dport"
    t.integer "udp_len"
    t.integer "udp_csum"
  end

  add_index "udphdr", ["cid"], :name => "index_udphdr_cid"
  add_index "udphdr", ["sid"], :name => "index_udphdr_sid"
  add_index "udphdr", ["udp_dport"], :name => "index_udphdr_udp_dport"
  add_index "udphdr", ["udp_sport"], :name => "index_udphdr_udp_sport"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "accept_notes",                        :default => 1
    t.integer  "notes_count",                         :default => 0
    t.integer  "events_count",                        :default => 0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "per_page_count",                      :default => 25
    t.integer  "favorites_count",                     :default => 0
    t.string   "name"
    t.boolean  "admin",                               :default => false
    t.boolean  "enabled",                             :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
