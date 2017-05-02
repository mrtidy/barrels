local module = {}

-- direct messages to their appropriate function based on topic
function module.handle_message(topic, data)
  local index = string.find(topic, "/[^/]*$")
  if index ~= nil then
    local subtopic = string.sub(topic, index + 1)
    print("handle_message: " .. subtopic)
    module.topic_handler_map[subtopic](data)
  end
end

-- start listening for messages on the topic
function module.listen()
  m.on("message", module.handle_message)
end

-- brightness expected in number 0 to 100
function module.set_brightness(data)
  brightness = data
  module.update_led()
end

-- color expected in hex rgb string like ffffff for white
function module.set_color(data)
  if string.len(data) ~= 6 then
    print("set_color ignoring " + data)
    return
  end
  color.red = tonumber(string.sub(data, 1, 2), 16)
  color.green = tonumber(string.sub(data, 3, 4), 16)
  color.blue = tonumber(string.sub(data, 5, 6), 16)
  module.update_led()
end

-- update duty using current brightness and color values
function module.update_led()
  pwm.setduty(config.PIN.RED, (color.red * 4) * (brightness / 100))
  pwm.setduty(config.PIN.GREEN, (color.green * 4) * (brightness / 100))
  pwm.setduty(config.PIN.BLUE, (color.blue * 4) * (brightness / 100))
end

module.topic_handler_map = {
  brightness = module.set_brightness,
  color = module.set_color
}

return module
