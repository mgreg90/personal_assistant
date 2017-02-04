# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

Thread.abort_on_exception = true

Thread.new do
  Bot.run
end

run Rails.application
