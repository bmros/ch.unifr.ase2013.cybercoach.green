class Api::Base < ActiveResource::Base
  self.site='http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/'
  #self.site = 'http://diufpc46.unifr.ch:8080'
  #self.prefix = ''
  #### Either this
  #self.user = "admin"
  #self.password = "4dm1n1d"
  self.format = :json


  #### Or this
  #headers['Authorization'] = 'Basic YWRtaW46NGRtMW4xZA=='


  headers['Accept'] = 'application/json'


  # Strip .xml extension off generated URLs
  ##################################
  ##  Take either this approach    #
  ##################################
  #class << self
  #  def element_path(id, prefix_options = {}, query_options = nil)
  #    check_prefix_options(prefix_options)
  #    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
  #    "#{prefix(prefix_options)}#{collection_name}/#{URI.parser.escape id.to_s}#{query_string(query_options)}"
  #  end
  #
  #  def collection_path(prefix_options = {}, query_options = nil)
  #    check_prefix_options(prefix_options)
  #    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
  #    "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
  #  end
  #
  #  def instantiate_collection(collection, prefix_options = {}, b = nil)
  #    #collection = collection[element_name.pluralize] if collection.instance_of?(Hash)
  #    collection = collection['listOfPatient']['patient'] if collection.instance_of?(Hash)
  #    #collection = JSON.parse(collection)['listOfPatient']
  #    collection.collect! { |record| instantiate_record(record, prefix_options) }
  #  end
  #
  #  def create
  #    run_callbacks :create do
  #      connection.put(collection_path, encode, self.class.headers).tap do |response|
  #        self.id = id_from_response(response)
  #        load_attributes_from_response(response)
  #      end
  #    end
  #  end
  #end

  #################################
  #     Or take this approach     #
  #################################
  class << self
    def element_path(id, prefix_options = {}, query_options = nil)
      super.gsub(/.json|.xml/,'')
    end

    def collection_path(prefix_options = {}, query_options = nil)
      super.gsub(/.json|.xml/,'')
    end

    def new_element_path
      super.gsub(/.json|.xml/,'')
    end
    #def instantiate_collection(collection, prefix_options = {}, b = nil)
    #  #collection = collection[element_name.pluralize] if collection.instance_of?(Hash)
    #  collection = collection['listOfPatient']['patient'] if collection.instance_of?(Hash)
    #  collection.collect! { |record| instantiate_record(record, prefix_options) }
    #end
  end
end