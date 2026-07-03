
BEGIN {
  FS = " "
  RS = "\n"
  OFS = ""
  ORS = ""

  topics = 1
}

/EXAMPLE/ {
  json[++topics] = "\"example\":\"" $3d "\""
}

END {
  print "{Brian William Hughes"
  for (i = 1; i < topics; i++) {
    print json[i] ","
  }
  print json[topics] "}"
}
