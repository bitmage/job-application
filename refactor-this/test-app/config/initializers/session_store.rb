# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_test-app_session',
  :secret      => '4ea93719b17b2ae25ed37ae13e60287c0f837fcea9e560a0db45f712f49337cf92c642aef4802f85aa9722eb176a8e2f87bc5230f9f5343f11da6d683c343945'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
