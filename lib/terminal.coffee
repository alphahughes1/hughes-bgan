# init = ->
#   cmee(2)
#   _iclck('ad', 0, adminPassword)
#   _ibnotify('_igps', 1)
#   _ibnotify('_ipoint', 1)
#   _ibnotify('_isleep', 1)
#   _ibnotify('+cgpaddr', 1)
#   _ibnotify('_ihreboot', 1)
#   _ibnotify('_ihstatus', 1)
#   _ibnotify('+cmti', 1)
#   _ibnotify('_ibalarm', 1)
#   _ibnotify('_ihbeam', 1)


module.exports = class Terminal
  
  constructor: (@password) ->
    @lineEnding = '\r\n'

  _iclck: (facility, mode) =>
    "at_iclck=\"#{facility}\",#{mode},\"#{@password}\"#{@lineEnding}"

  _icpwd: (facility, newPassword) =>
    @password = newPassword
    "at_icpwd=\"#{facility}\",#{@password},\"#{newPassword}\"#{@lineEnding}"

  _ipoint: =>
    "at_ipoint?#{@lineEnding}"

  _igps: =>
    "at_igps?#{@lineEnding}"

  _inis: (interface) =>
    "at_inis=\"#{interface}\"#{@lineEnding}"

  _ilog: (file, lines, offset) =>
    "at_ilog=\"#{file}\",#{lines},0,#{offset}#{@lineEnding}"

  _isig: =>
    "at_isig?#{@lineEnding}"

  _isatinfo: =>
    "at_isatinfo#{@lineEnding}"

  _isatvis: =>
    "at_isatvis#{@lineEnding}"

  _isatcur: =>
    "at_isatcur?#{@lineEnding}"

  _ibnotify: (command, status) =>
    "at_ibnotify=\"#{command}\",#{status}#{@lineEnding}"

  cgmi: =>
    "at+cgmi#{@lineEnding}"

  cgmm: =>
    "at+cgmm#{@lineEnding}"

  cgmn: =>
    "at+cgmn#{@lineEnding}"

  cgmp: =>
    "at+cgmp#{@lineEnding}"

  cgmr: =>
    "at+cgmr#{@lineEnding}"

  cgms: =>
    "at+cgms#{@lineEnding}"

  cgsn: =>
    "at+cgsn#{@lineEnding}"

  cimi: =>
    "at+cimi#{@lineEnding}"

  cpas: =>
    "at+cpas#{@lineEnding}"

  cfun: (level, reset) =>
    if level and reset
      "at+cfun=#{level},#{reset}#{@lineEnding}"
    else
      "at+cfun?#{@lineEnding}"

  cbc: =>
    "at+cbc#{@lineEnding}"

  cmee: (level) =>
    "at+cmee=#{level}#{@lineEnding}"

  _ihstatus: (subsystem) =>
    if subsystem
      "at_ihstatus=\"#{subsystem}\"#{@lineEnding}"
    else
      "at_ihstatus?#{@lineEnding}"

  _ihread: (subsystem) =>
    if subsystem
      "at_ihread=\"#{subsystem}\"#{@lineEnding}"
    else
      "at_ihread?#{@lineEnding}"

  _ihgf: =>
    "at_ihgf#{@lineEnding}"

  _ihbeam: =>
    "at_ihbeam?#{@lineEnding}"

  _ihpbit: (subsystem) =>
    if subsystem
      "at_ihpbit=\"#{subsystem}\"#{@lineEnding}"
    else
      "at_ihpbit=\"all\"#{@lineEnding}"

  _ihtemp: =>
    "at_ihtemp=\"vr\"#{@lineEnding}"
