local module = {
  WIFI = {
    SSID = "sec269N",
    PASSWORD = "8deadbeefa7cafe"
  },

  MQTT = {
    HOST = "192.168.0.222",
    PORT = 1883,
    KEEP_ALIVE = 120,
    TOPIC_BASE = "barrels/"
  },

  ID = node.chipid(),

  PIN = {
    STATUS = 0,
    RED = 1,
    GREEN = 2,
    BLUE = 3
  }
}
return module
