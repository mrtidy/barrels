config = dofile("config.lc")

gpio.write(config.PIN.STATUS, gpio.LOW)
pwm.setup(config.PIN.RED, 500, 0)
pwm.start(config.PIN.RED)
pwm.setup(config.PIN.GREEN, 500, 0)
pwm.start(config.PIN.GREEN)
pwm.setup(config.PIN.BLUE, 500, 0)
pwm.start(config.PIN.BLUE)

brightness = 50
color = {red = 0, green = 0, blue = 0}

-- TODO - would like to change setup to accept parameter
-- so main.listen can be provided as callback when setup complete
dofile("setup.lc")
main = dofile("main.lc")
