require "chicago_libraries/version"
require 'unirest'

module ChicagoLibraries


  class Library
    attr_accessor :zip_code, :phone, :teacher_in_library, :longitude, :latitude, :website, :address, :hours, :state, :cybernavigator, :name, :city

    def initialize(library_info)
      @zip_code = library_info["zip"],
      @phone = library_info["phone"],
      @teacher_in_library = library_info["teacher_in_the_library"],
      @longitude = library_info["location"]["longitude"],
      @latitude = library_info["location"]["latitude"],
      @website = library_info["website"]["url"],
      @address = library_info["address"],
      @hours = library_info["hours_of_operation"],
      @state = library_info["state"],
      @cybernavigator = library_info["cybernavigator"],
      @name = library_info["name_"],
      @city = library_info["city"]
    end

    def self.all
      api_array = Unirest.get("https://data.cityofchicago.org/resource/x8fc-8rcq.json").body
      create_libraries(api_array)
    end

    def self.search(search_keyword)
      api_array = Unirest.get("https://data.cityofchicago.org/resource/x8fc-8rcq.json?$q=#{search_keyword}").body
      create_libraries(api_array)
    end

    def self.create_libraries(api_array)
      libraries = []

      api_array.each do |library_info|
        libraries << Library.new(library_info)
      end
      libraries
    end

    private_class_method :create_libraries
  end

end
