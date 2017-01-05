require "metadata/version"
require "metadata/hook"
require "metadata/formats"

module Metadata
  include Hook
  
  def self.included(base)
    base.extend Hook::ClassMethods
  end
end

require "metadata/rails/model/active_record" if Rails
