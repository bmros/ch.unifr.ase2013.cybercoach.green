require 'active_resource'

class  Sport < Api::Base

  self.primary_key = 'name'

  class << self
    def instantiate_collection(collection, prefix_options = {}, b = nil)
      collection = collection['sports'] if collection.instance_of?(Hash)
      collection.collect! { |record| instantiate_record(record, prefix_options) }
    end
  end

  schema do
    string 'uri', 'name'
  end

  #validates :lastName,  :presence => true, :length => { :maximum => 50 }
  #validates :firstName, :presence => true, :length => { :minimum => 6 }


end