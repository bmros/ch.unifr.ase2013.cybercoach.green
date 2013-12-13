require 'active_resource'

class Subscription < Api::Base

#self.site = 'http://diufvm31.unifr.ch:8090'
#self.site = 'http://diufpc46.unifr.ch:8080'

  #self.prefix = '/users/aabb'
#self.prefix = '/CyberCoachServer/resources/users/aabb/Running'
#self.prefix = '/CyberCoachServer/resources/users/:user_id'

#self.user = "newuser1"
#self.password = "newuser"

# To handle the issue with getting the resources by name (e.g. ../resources/sports/Running not ../sports/1)
# you can set the primary_key to the created api class extending the ActiveResource::Base class.
#self.primary_key = 'users'

# singular name of the resource. you only need to specify this if this class name is not the resource name
#self.element_name = ''
# define a callback method for accessing header information in the response
#add_response_method :http_response

#class << self
 # def instantiate_collection(collection, prefix_options = {}, b = nil)
  #  collection = collection if collection.instance_of?(Hash)
   # collection.collect! { |record| instantiate_record(record, prefix_options) }
  #end
#end


#schema do
#  string 'uri', 'sport'
#  integer 'id', 'publicvisible'
#end

#def prefix_options
#  { :user_id => user_id }
#end

#validates :lastName,  :presence => true, :length => { :maximum => 50 }
#validates :firstName, :presence => true, :length => { :minimum => 6 }

self.primary_key = 'username'
#self.user = session[:current_userlink_id]
#self.password = session[:current_userlink_password]




  class << self
    def instantiate_collection(collection, prefix_options = {}, b = nil)
      collection = collection['subscriptions'] if collection.instance_of?(Hash)
      collection.collect! { |record| instantiate_record(record, prefix_options) }
    end
  end

  schema do
    string 'uri', 'username', 'password', 'realname', 'email', 'subscriptions', 'partnerships'
    integer 'publicvisible'
  end

  #validates :lastName,  :presence => true, :length => { :maximum => 50 }
  #validates :firstName, :presence => true, :length => { :minimum => 6 }





end