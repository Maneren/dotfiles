function pastart
    pastop >/dev/null 2>&1
    pactl load-module module-null-sink sink_name=rtp format=s16be channels=2 rate=48000
    pactl load-module module-rtp-send source=rtp.monitor destination=224.0.0.56 port=4010 mtu=480
end
