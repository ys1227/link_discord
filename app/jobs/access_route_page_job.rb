class AccessRoutePageJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    uri = URI("https://link-disco.onrender.com")
    response = Net::HTTP.get_response(uri)
  end
end
