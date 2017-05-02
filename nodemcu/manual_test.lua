--[[
Use this to manually test the main functions.

Example:
> require "manual_test"
chipid: invoked
> main.handle_message(nil, "nodemcu/24601/color", "ffffff")
handle_message: color
setduty: invoked: 1: 510
setduty: invoked: 2: 510
setduty: invoked: 3: 510
> main.handle_message(nil, "nodemcu/24601/brightness", 100)
handle_message: brightness
setduty: invoked: 1: 1020
setduty: invoked: 2: 1020
setduty: invoked: 3: 1020
> main.set_brightness(20)
setduty: invoked: 1: 204
setduty: invoked: 2: 204
setduty: invoked: 3: 204
> main.set_color("0a0a0a")
setduty: invoked: 1: 8
setduty: invoked: 2: 8
setduty: invoked: 3: 8
--]]

brightness = 50
color = {red = 0, green = 0, blue = 0}

-- MOCKS
node = {}
function node.chipid()
  print("chipid: invoked")
end
pwm = {}
function pwm.setduty(pin, duty)
  print("setduty: invoked: " .. pin .. ": " .. duty)
end

config = require "config"
app = require "app"