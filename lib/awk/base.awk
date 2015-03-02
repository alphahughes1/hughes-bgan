BEGIN {
  # Field Separator (" " by default)
  FS = " ";

  # Record Separator (lines)
  RS = "\n";

  # Output Field Separator
  OFS = "";

  # Output Record Separator (lines)
  ORS = "";

  print "{";
}

/FLTS/ {
  print "\"faults\":", $3, ",";
}

/GPS/ {
  print "\"gps\":{",
          "\"lat\":\"",    $3, "\",",
          "\"lon\":\"",    $4, "\",",
          "\"fix\":\"",    $5, "\",",
          "\"status\":\"", $6, "\",",
          "\"date\":\"",   $7, "\",",
          "\"time\":\"",   $8, "\"",
        "},";
}

/ETH/ {
  print "\"ethernet\":", $3, ",";
}

/USB/ {
  print "\"usb\":", $3, ",";
}

/SIG/ {
  print "\"signal\":", $2, ",";
}

/SATCUR/ {
  print "\"satellite_id\":", $2, ",";
}

/TEMP/ {
  print "\"temp\":", $3, ",";
}

/BEAM/ {
  print "\"beam_id\":", $2, ",";
}

/CIMI/ {
  print "\"imsi\":\"", $2, "\",";
}

/IMEI/ {
  print "\"imei\":\"", $3, "\",";
}

/UNITIP/ {
  print "\"ip\":\"", $3, "\"";
}

END {
  print "}";
}
