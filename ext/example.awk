
BEGIN {
  FS = " "
  RS = "\n"
  OFS = ""
  ORS = ""

  topics = -1
}

/EXAMPLE/ {
  json[++topics] = "\"example\":\"" $3 "\""
}

END {
  print "{"
  for (i = 0; i < topics; i++) {
    print json[i] ","
  }
  print json[topics] "}"
}
