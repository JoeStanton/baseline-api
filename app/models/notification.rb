class Notification
  def self.trigger(channel, payload)
    puts "#{channel} #{payload}"
  end
end
