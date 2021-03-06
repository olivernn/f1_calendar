ActiveSupport::Notifications.subscribe "ergast.request" do |name, start, finish, id, payload|
  log("Ergast Request: #{payload[:method].to_s.upcase} #{payload[:url]}", start, finish)
end

ActiveSupport::Notifications.subscribe "ergast.response" do |name, start, finish, id, payload|
  log("Ergast Response: #{payload[:status]}", start, finish)
end

ActiveSupport::Notifications.subscribe "cache_write.active_support" do |name, start, finish, id, payload|
  log("Cache WRITE to #{payload[:key]}", start, finish)
end

ActiveSupport::Notifications.subscribe "cache_read.active_support" do |name, start, finish, id, payload|
  type = payload[:hit] ? "HIT" : "MISS"
  log("Cache #{type} on #{payload[:key]}", start, finish)
end

def log(message, start, finish)
  duration = finish - start

  log = [
    message,
    "(#{duration.round(3)}s)"
  ]
  log = "    #{log.compact.join("\t")}"

  Rails.logger.info(log)
end

