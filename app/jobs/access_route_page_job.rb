class AccessRoutePageJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    uri = URI("https://www.linkdisco-app.com")
    response = Net::HTTP.get_response(uri)
  end
end
