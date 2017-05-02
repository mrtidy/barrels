local function mqtt_start()
  m = mqtt.Client(config.ID, config.MQTT.KEEP_ALIVE)
  m.connect(config.MQTT.HOST, config.MQTT.PORT, 0,
    function()
      m.lwt(config.MQTT.TOPIC_BASE .. config.ID .. "/status", "offline", 0, true)
      m.publish(config.MQTT.TOPIC_BASE .. config.ID .. "/status", "online", 0, true)
      m.subscribe({
        [config.MQTT.TOPIC_BASE .. config.ID .. "/brightness"] = 1,
        [config.MQTT.TOPIC_BASE .. config.ID .. "/color"] = 1
      },
        function()
          main.listen()
        end
      )
    end
  )
end

local function wifi_wait_ip()
  if wifi.sta.getip() == nil then
    print("IP unavailable, Waiting...")
  else
    tmr.stop(1)
    print("===")
    print("IP is: " .. wifi.sta.getip())
    print("===")
    mqtt_start()
  end
end

local function wifi_start()
  wifi.sta.config(config.WIFI.SSID, config.WIFI.PASSWORD)
  wifi.sta.connect()
  print("Connecting to " .. config.WIFI.SSID .. "...")
  tmr.alarm(1, 2500, 1, wifi_wait_ip)
end

print("Configuring Wifi...")
wifi.setmode(wifi.STATION)
wifi.sta.getap(wifi_start)
