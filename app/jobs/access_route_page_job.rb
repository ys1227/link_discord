class AccessRoutePageJob < ApplicationJob
  queue_as :default

  def perform(*args)
    uri = URI("https://link-disco.onrender.com")
    response = Net::HTTP.get_response(uri) 
   end
end
