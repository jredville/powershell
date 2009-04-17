get-process -name aspnet_wp        -erroraction silentlycontinue | stop-process
get-process -name w3wp             -erroraction silentlycontinue | stop-process
get-process -name webdev.webserver -erroraction silentlycontinue | stop-process
