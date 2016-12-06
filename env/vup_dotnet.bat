SET vm=.net
REM first time need this plugin
vagrant plugin install vagrant-host-shell
vagrant up
REM Not sure how to get around reboot yet, some sym link issue causes I/O errors reboot seems to fix.
vagrant reload 
