class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared