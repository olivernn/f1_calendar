ActiveSupport::Notifications.subscribe "ergast.request" do |name, start, finish, id, payload|
  log("Ergast Request: #{payload[:method].to_s.upcase} #{payload[:url]}", start, finish)
end

ActiveSupport::Notifications.subscribe "ergast.response" do |name, start, finish, id, payload|
  log("Ergast Response: #{payload[:status]}", start, finish)
end

def log(message, start, finish)
  duration = finish - start

  log = [
    message,
    "(#{duration.round(3)}s)"
  ]
  log = "    #{log.compact.join("\t")}"

  Rails.logger.debug(log)
end

