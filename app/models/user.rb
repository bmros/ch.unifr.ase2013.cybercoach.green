require 'active_resource'

class User < Api::Base

  class << self
    def instantiate_collection(collection, prefix_options = {}, b = nil)
      collection = collection['users'] if collection.instance_of?(Hash)
      collection.collect! { |record| instantiate_record(record, prefix_options) }
    end
  end


  schema do
    string 'username'
	string 'password'
    string 'realname'
	string 'email'
	integer 'publicvisible'
  end


  #validates :lastName,  :presence => true, :length => { :maximum => 50 }
  #validates :firstName, :presence => true, :length => { :minimum => 6 }


end
