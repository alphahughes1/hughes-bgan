BEGIN {
  FS = " "
  RS = "\n"
  OFS = ""
  ORS = ""
  
  topics = -1
}

/FLTS/ {
  json[++topics] = "\"faults\":" $3
}

/GPS/ {
  # "gps": {
  #   "lat": "$3",
  #   "lon":" "$4",
  #   "fix":" "$5",
  #   "status": "$6",
  #   "date": "$7",
  #   "time": "$8"
  # }
  json[++topics] = "\"gps\":{" "\"lat\":\"" $3 "\"," "\"lon\":\"" $4 "\"," "\"fix\":\"" $5 "\"," "\"status\":\"" $6 "\"," "\"date\":\"" $7 "\"," "\"time\":\"" $8 "\"}"
}

/ETH/ {
  json[++topics] = "\"ethernet\":" $3
}

/USB/ {
  json[++topics] = "\"usb\":" $3
}

/SIG/ {
  json[++topics] = "\"signal\":" $2
}

/SATCUR/ {
  json[++topics] = "\"satellite_id\":" $2
}

/TEMP/ {
  json[++topics] = "\"temp\":" $3
}

/BEAM/ {
  json[++topics] = "\"beam_id\":" $2
}

/CIMI/ {
  json[++topics] = "\"imsi\":\"" $2 "\""
}

/IMEI/ {
  json[++topics] = "\"imei\":\"" $3 "\""
}

/UNITIP/ {
  json[++topics] = "\"ip\":\"" $3 "\""
}

END {
  print "{"
  for (i = 0; i < topics; i++) {
    print json[i] ","
  }
  print json[topics] "}"
}
