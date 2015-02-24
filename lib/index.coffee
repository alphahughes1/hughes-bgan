
# Used to lock, unlock or interrogate a MT facility. Password is
# normally needed to do such actions.
_iclck = (facility, mode, password) -> #socket.write('at_iclck="ad",0,"admin"\r\n');

# Sets a new password for the facility lock function defined by command
# _ICLCK.
_icpwd = (facility, oldPassword, newPassword) ->
