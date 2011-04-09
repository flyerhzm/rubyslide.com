# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
#ActionController::Base.session = {
  #:key         => '_rubyslide_session',
  #:secret      => '31a569a7589e10e469b3b9f61ef530e251f2aeeb9eb7699f85851b13b881ba703bf73c6cbd0ee664a62c594db0c0fd7d72ea02076a6bd9375ec456236b21a9bf'
#}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

# Session cache
ActionController::Base.session = {
  :namespace   => 'sessions',
  :expire_after => 30.minutes.to_i,
  :key         => '_rubyslide_session',
  :secret      => '31a569a7589e10e469b3b9f61ef530e251f2aeeb9eb7699f85851b13b881ba703bf73c6cbd0ee664a62c594db0c0fd7d72ea02076a6bd9375ec456236b21a9bf'
}

require 'action_controller/session/dalli_store'
ActionController::Base.session_store = :dalli_store

