# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Homeassistant features set"
HOMEPAGE="https://github.com/xavierforestier/HomeAssistantRepository"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 x86"
IUSE="minimal normal full"
REQUIRED_USE=" ^^ ( minimal normal full ) "
RDEPEND="
	minimal? ( app-misc/homeassistant[accuweather,airly,airvisual,alpha_vantage,analytics_insights,androidtv,androidtv_remote,android_ip_webcam,axis,backup,bluetooth,bluetooth_tracker,caldav,camera,cast,cli,co2signal,compensation,coronavirus,dlna_dmr,dlna_dms,dwd_weather_warnings,ecowitt,enigma2,esphome,ffmpeg,file,forecast_solar,fronius,github,glances,holiday,homekit,homekit_controller,http,hyperion,ibeacon,influxdb,isal,knx,kodi,kraken,local_calendar,local_todo,mariadb,matter,maxcube,mikrotik,mobile_app,modbus,mosquitto,mqtt,mysensors,mysql,nextcloud,nfandroidtv,notify_events,octoprint,onvif,openweathermap,otp,owntracks,ping,plex,ps4,python_script,qnap,qvr_pro,radio_browser,recorder,rest,ring,ruuvi_gateway,samsungtv,scrape,season,shelly,signal_messenger,snmp,socat,sonos,speedtestdotnet,spotify,sql,ssl,systemd,systemmonitor,tankerkoenig,tasmota,tile,tomorrowio,tplink,upnp,utility_meter,version,wake_on_lan,waze_travel_time,wemo,whois,wled,workday,xiaomi_aqara,yamaha,yamaha_musiccast,zeroconf,zha,zwave_js] )
	normal? ( app-misc/homeassistant[abode,accuweather,acer_projector,acmeda,adguard,ads,aftership,agent_dvr,airly,airvisual,alarmdecoder,alpha_vantage,ambient_station,amcrest,ampio,analytics_insights,androidtv,androidtv_remote,android_ip_webcam,anthemav,apache_kafka,apcupsd,apple_tv,apprise,aquostv,arcam_fmj,aruba,asuswrt,aten_pe,atome,august,aurora_abb_powerone,avea,avion,awair,axis,backup,baidu,beewi_smartclim,bh1750,bitcoin,bizkaibus,blackbird,blebox,blink,blinkt,blockchain,bluetooth,bluetooth_tracker,bme280,bmw_connected_drive,bond,braviatv,bring,broadlink,brottsplatskartan,brunt,bsblan,bt_home_hub_5,bt_smarthub,buienradar,caldav,camera,canary,cast,cisco_mobility_express,cli,co2signal,compensation,coronavirus,daikin,deconz,delijn,denonavr,deutsche_bahn,devolo_home_control,dexcom,dhcp,dht,discogs,discord,dlna_dmr,dlna_dms,doorbird,dunehd,dwd_weather_warnings,dynalite,ecobee,ecowitt,emulated_roku,enigma2,enocean,enphase_envoy,environment_canada,esphome,everlights,evohome,ffmpeg,fibaro,file,flume,flux_led,foobot,forecast_solar,fortios,freebox,fritz,fritzbox,fritzbox_callmonitor,fronius,gios,github,glances,gogogate2,greeneye_monitor,growatt_server,guardian,harman_kardon_avr,harmony,heos,here_travel_time,holiday,homekit,homekit_controller,homematic,homematicip_cloud,hp_ilo,http,hue,hydrawise,iaqualink,ibeacon,ihc,image_upload,imap,incomfort,influxdb,insteon,intesishome,ipma,ipp,isal,islamic_prayer_times,jewish_calendar,joaoapps_join,kef,knx,kodi,kraken,lifx,linode,litterrobot,local_calendar,local_todo,loopenergy,luci,luftdaten,mariadb,matter,maxcube,media_extractor,met,meteo_france,mfi,mikrotik,mobile_app,modbus,mosquitto,mqtt,mysql,nad,nederlandse_spoorwegen,netatmo,netdata,nextcloud,nfandroidtv,nmap_tracker,notify_events,nuki,nut,nws,nx584,octoprint,onkyo,onvif,opengarage,opensensemap,openweathermap,opnsense,otp,owntracks,panasonic_viera,philips_js,pilight,ping,pi_hole,plex,plugwise,poolsense,powerwall,ps4,python_script,qnap,qvr_pro,rachio,radio_browser,rainbird,rainmachine,recorder,rejseplanen,rest,ring,roku,roomba,roon,ruuvi_gateway,samsungtv,scrape,season,shelly,shodan,signal_messenger,simplisafe,skybell,sma,smappee,smarthab,smartthings,snmp,socat,solax,somfy,sonos,speedtestdotnet,spotify,sql,squeezebox,ssl,statsd,synology_dsm,systemd,systemmonitor,tankerkoenig,tasmota,tellduslive,tesla,tile,tomorrowio,toon,totalconnect,tplink,tts,tuya,unifi,unifi_direct,upnp,usb,utility_meter,vallox,velbus,velux,vera,version,vicare,vizio,wake_on_lan,waqi,waze_travel_time,webostv,wemo,whois,wink,withings,wled,workday,xbox,xiaomi_aqara,xiaomi_miio,xiaomi_tv,xs1,yamaha,yamaha_musiccast,yeelight,yi,zeroconf,zerproc,zha,zhong_hong,zoneminder,zwave_js] )
	full? ( app-misc/homeassistant[abode,acaia,accuweather,acer_projector,acmeda,adax,adguard,ads,advantage_air,aemet,aftership,agent_dvr,airgradient,airly,airnow,airq,airthings,airthings_ble,airtouch4,airtouch5,airvisual,airvisual_pro,airzone,airzone_cloud,alarmdecoder,alpha_vantage,amazon_polly,amberelectric,ambient_network,ambient_station,amcrest,ampio,analytics_insights,android_ip_webcam,androidtv,androidtv_remote,anel_pwrctrl,anova,anthemav,anthropic,aosmith,apache_kafka,apcupsd,apple_tv,apprise,aprilaire,aprs,apsystems,aquacell,aqualogic,aquostv,aranet,arcam_fmj,arris_tg2492lg,aruba,arve,aseko_pool_live,assist_pipeline,asuswrt,atag,aten_pe,atome,august,aurora,aurora_abb_powerone,aussie_broadband,autarco,avea,avion,awair,aws,axis,azure_data_explorer,azure_devops,azure_event_hub,azure_service_bus,azure_storage,backup,baf,baidu,balboa,bang_olufsen,bbox,beewi_smartclim,bh1750,bitcoin,bizkaibus,blackbird,blebox,blink,blinkt,blockchain,blue_current,bluemaestro,bluesound,bluetooth,bluetooth_tracker,bme280,bmw_connected_drive,bond,bosch_alarm,bosch_shc,braviatv,bring,broadlink,brother,brottsplatskartan,brunt,bryant_evolution,bsblan,bt_home_hub_5,bt_smarthub,bthome,buienradar,caldav,cambridge_audio,camera,canary,cast,ccm15,chacon_dio,channels,cisco_ios,cisco_mobility_express,cisco_webex_teams,clementine,cli,cloud,cloudflare,cmus,co2signal,coinbase,color_extractor,comelit,comfoconnect,command_line,compensation,concord232,control4,conversation,cookidoo,coolmaster,coronavirus,cppm_tracker,cpuspeed,crownstone,cups,daikin,danfoss_air,datadog,deako,debugpy,deconz,decora,decora_wifi,delijn,deluge,denonavr,deutsche_bahn,devialet,devolo_home_control,devolo_home_network,dexcom,dhcp,dht,digital_ocean,directv,discogs,discord,discovergy,dlib_face_detect,dlib_face_identify,dlink,dlna_dmr,dlna_dms,dnsip,dominos,doods,doorbird,dormakaba_dkey,dremel_3d_printer,drop_connect,dsmr,duke_energy,dunehd,duotecno,dwd_weather_warnings,dweet,dynalite,eafm,easyenergy,ebox,ebusd,ecoal_boiler,ecobee,ecoforest,econet,ecovacs,ecowitt,eddystone_temperature,edimax,edl21,efergy,egardia,eheimdigital,electrasmart,electric_kiwi,elevenlabs,elgato,eliqonline,elkm1,elmax,elv,elvia,emby,emoncms,emonitor,emulated_kasa,emulated_roku,energenie_power_sockets,energyzero,enigma2,enocean,enphase_envoy,entur_public_transport,environment_canada,envisalink,ephember,epic_games_store,epion,epson,eq3btsmart,escea,esphome,etherscan,eufy,eufylife_ble,everlights,evil_genius_labs,evohome,ezviz,faa_delays,familyhub,fastdotcom,feedreader,ffmpeg,fibaro,fido,file,fints,fireservicerota,firmata,fitbit,fivem,fixer,fjaraskupan,fleetgo,flexit_bacnet,flic,flick_electric,flipr,flo,flume,flux_led,folder_watcher,foobot,forecast_solar,forked_daapd,fortios,foscam,free_mobile,freebox,freedompro,fritz,fritzbox,fritzbox_callmonitor,fronius,frontend,frontier_silicon,fujitsu_fglair,fully_kiosk,futurenow,fyta,garages_amsterdam,gardena_bluetooth,gc100,gdacs,generic,geniushub,geo_json_events,geo_rss_events,geocaching,geonetnz_quakes,geonetnz_volcano,gios,github,gitlab_ci,gitter,glances,go2rtc,goalzero,gogogate2,goodwe,google,google_assistant_sdk,google_cloud,google_drive,google_generative_ai_conversation,google_mail,google_maps,google_photos,google_pubsub,google_sheets,google_tasks,google_translate,google_travel_time,govee_ble,govee_light_local,gpsd,gree,greeneye_monitor,greenwave,growatt_server,gstreamer,gtfs,guardian,habitica,hardware,harman_kardon_avr,harmony,hassio,hdmi_cec,heatmiser,heos,here_travel_time,hikvision,hikvisioncam,hisense_aehw4a1,hive,hko,hlk_sw16,holiday,home_connect,homeassistant_hardware,homee,homekit,homekit_controller,homematic,homematicip_cloud,homewizard,homeworks,honeywell,horizon,hp_ilo,html5,http,huawei_lte,hue,huisbaasje,hunterdouglas_powerview,husqvarna_automower,husqvarna_automower_ble,huum,hvv_departures,hydrawise,hyperion,ialarm,iammeter,iaqualink,ibeacon,icloud,idasen_desk,idteck_prox,ifttt,iglo,igloohome,ign_sismologia,ihc,image_upload,imap,imgw_pib,improv_ble,incomfort,influxdb,inkbird,insteon,intellifire,intesishome,iometer,iotawatt,iotty,iperf3,ipma,ipp,iqvia,irish_rail_transport,iron_os,isal,iskra,islamic_prayer_times,israel_rail,iss,ista_ecotrend,isy994,itach,ituran,izone,jellyfin,jewish_calendar,joaoapps_join,juicenet,justnimbus,jvc_projector,kaiterra,kaleidescape,keba,keenetic_ndms2,kef,kegtron,keyboard,keyboard_remote,keymitt_ble,kira,kiwi,kmtronic,knocki,knx,kodi,konnected,kostal_plenticore,kraken,kulersky,kwb,lacrosse,lacrosse_view,lamarzocco,lametric,landisgyr_heat_meter,lastfm,launch_library,laundrify,lcn,ld2410_ble,leaone,led_ble,lektrico,letpot,lg_netcast,lg_soundbar,lg_thinq,lidarr,lifx,lightwave,limitlessled,linear_garage_door,linkplay,linode,linux_battery,lirc,litejet,litterrobot,livisi,local_calendar,local_todo,london_underground,lookin,loopenergy,loqed,luci,luftdaten,lupusec,lutron,lutron_caseta,lw12wifi,lyric,madvr,mailgun,mariadb,marytts,mastodon,matrix,matter,maxcube,mcp,mcp_server,mealie,meater,medcom_ble,media_extractor,mediaroom,melcloud,melissa,melnor,message_bird,met,met_eireann,meteo_france,meteoalarm,meteoclimatic,metoffice,mfi,microbees,microsoft,mikrotik,mill,minecraft_server,minio,moat,mobile_app,mochad,modbus,modem_callerid,modern_forms,moehlenhoff_alpha2,monarch_money,monoprice,monzo,mopeka,mosquitto,motion_blinds,motionblinds_ble,motioneye,motionmount,mpd,mqtt,msteams,mullvad,music_assistant,mutesync,mysensors,mysql,mystrom,mythicbeastsdns,myuplink,nad,nam,namecheapdns,nanoleaf,nasweb,neato,nederlandse_spoorwegen,ness_alarm,nest,netatmo,netdata,netgear,netgear_lte,netio,network,neurio_energy,nexia,nextbus,nextcloud,nextdns,nfandroidtv,nibe_heatpump,nice_go,nightscout,niko_home_control,nilu,nina,nissan_leaf,nmap_tracker,nmbs,noaa_tides,nobo_hub,nordpool,norway_air,notify_events,notion,nsw_fuel_station,nsw_rural_fire_service_feed,nuheat,nuki,numato,nut,nws,nx584,nyt_games,nzbget,oasa_telematics,obihai,octoprint,oem,ohmconnect,ohme,ollama,ombi,omnilogic,oncue,ondilo_ico,onedrive,onewire,onkyo,onvif,open_meteo,openai_conversation,openerz,openevse,openexchangerates,opengarage,openhome,opensensemap,opensky,opentherm_gw,openuv,openweathermap,opnsense,opower,opple,oralb,oru,orvibo,osoenergy,osramlightify,otbr,otp,ourgroceries,overkiz,overseerr,ovo_energy,owntracks,p1_monitor,palazzetti,panasonic_bluray,panasonic_viera,pandora,peblar,peco,pegel_online,pencom,permobil,pglab,philips_js,pi_hole,picnic,pilight,ping,pjlink,plaato,plex,plugwise,plum_lightpad,pocketcasts,point,poolsense,powerfox,powerwall,private_ble_device,profiler,progettihwsw,proliphix,prometheus,prosegur,proxmoxve,proxy,prusalink,ps4,pterodactyl,pulseaudio_loopback,pure_energie,purpleair,pushbullet,pushover,pvoutput,pvpc_hourly_pricing,pyload,python_script,qbittorrent,qbus,qingping,qld_bushfire,qnap,qnap_qsw,qrcode,quantum_gateway,qvr_pro,qwikswitch,rabbitair,rachio,radarr,radio_browser,radiotherm,rainbird,raincloud,rainforest_eagle,rainforest_raven,rainmachine,rapt_ble,raspyrfm,rdw,recollect_waste,recorder,recswitch,reddit,refoss,rejseplanen,remember_the_milk,remote_calendar,remote_rpi_gpio,renault,renson,reolink,repetier,rest,rflink,rfxtrx,ridwell,ring,ripple,risco,rituals_perfume_genie,rmvtransport,roborock,rocketchat,roku,romy,roomba,roon,route53,rova,rpi_power,ruckus_unleashed,russound_rio,russound_rnet,ruuvi_gateway,ruuvitag_ble,rympro,sabnzbd,saj,samsungtv,sanix,satel_integra,schlage,schluter,scrape,screenlogic,scsgate,season,sendgrid,sense,sensibo,sensirion_ble,sensorpro,sensorpush,sensorpush_cloud,sensoterra,sentry,senz,serial,serial_pm,sesame,seven_segments,seventeentrack,sfr_box,sharkiq,shelly,shodan,sia,sighthound,signal_messenger,simplefin,simplepush,simplisafe,sinch,sisyphus,sky_hub,sky_remote,skybeacon,skybell,slack,sleepiq,slide,slide_local,slimproto,sma,smappee,smart_meter_texas,smarthab,smartthings,smarttub,smarty,smhi,smlight,sms,snapcast,snmp,snoo,snooz,socat,solaredge,solaredge_local,solarlog,solax,soma,somfy,somfy_mylink,sonarr,songpal,sonos,sony_projector,soundtouch,spc,speedtestdotnet,splunk,spotify,sql,squeezebox,srp_energy,ssdp,ssl,starline,starlingbank,starlink,startca,statsd,steam_online,steamist,stiebel_eltron,stookwijzer,stream,streamlabswater,subaru,suez_water,supla,surepetcare,swiss_hydrological_data,swiss_public_transport,switchbee,switchbot,switchbot_cloud,switcher_kis,switchmate,syncthing,syncthru,synology_dsm,synology_srm,system_bridge,systemmonitor,tado,tailscale,tailwind,tami4,tank_utility,tankerkoenig,tapsaff,tasmota,tautulli,technove,ted5000,tedee,telegram_bot,tellduslive,tellstick,temper,tensorflow,tesla,tesla_fleet,tesla_wall_connector,teslemetry,tessie,test,thermobeacon,thermopro,thethingsnetwork,thingspeak,thinkingcleaner,thread,tibber,tikteck,tile,tilt_ble,tmb,todoist,tolo,tomorrowio,toon,totalconnect,touchline,touchline_sl,tplink,tplink_lte,tplink_omada,traccar,traccar_server,tractive,tradfri,trafikverket_camera,trafikverket_ferry,trafikverket_train,trafikverket_weatherstation,transmission,transport_nsw,travisci,trend,triggercmd,tts,tuya,twentemilieu,twilio,twinkly,twitch,twitter,ubus,ukraine_alarm,unifi,unifi_direct,unifiled,unifiprotect,upb,upc_connect,upcloud,upnp,uptimerobot,usb,usgs_earthquakes_feed,utility_meter,uvc,v2c,vallox,vasttrafik,velbus,velux,venstar,vera,verisure,versasense,version,vesync,vicare,vilfo,vivotek,vizio,vlc,vlc_telnet,vodafone_station,voip,volkszaehler,volumio,volvooncall,vulcan,vultr,w800rf32,wake_on_lan,wallbox,waqi,waterfurnace,watergate,watson_iot,watttime,waze_travel_time,weatherflow,weatherflow_cloud,weatherkit,webdav,webmin,webostv,weheat,wemo,whirlpool,whois,wiffi,wilight,wink,wirelesstag,withings,wiz,wled,wmspro,wolflink,workday,ws66i,wyoming,xbox,xeoma,xiaomi_aqara,xiaomi_ble,xiaomi_miio,xiaomi_tv,xmpp,xs1,yale,yale_smart_alarm,yalexs_ble,yamaha,yamaha_musiccast,yandex_transport,yardian,yeelight,yeelightsunflower,yi,yolink,youless,youtube,zabbix,zamg,zeroconf,zerproc,zestimate,zeversolar,zha,zhong_hong,ziggo_mediabox_xl,zoneminder,zwave_js,zwave_me] )
"
