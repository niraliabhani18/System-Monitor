#!/bin/bash
# Assignment1 script - Linux System Change Logger Script

count=1
while true
do
exec &> mySysMonitor.log

#temp=1

##### Constants

TITLE="Linux System Change Logger Script for $HOSTNAME"
RIGHT_NOW=$(date)
#"%x %r %Z")
TIME_STAMP="Updated on $RIGHT_NOW by $USER"

##### Functions

counter()
{
echo "<pre>"
echo "$temp"
echo "</pre>"
}
current_process()
{
#echo "<h2>Current Processes running</h2>"
    echo "<pre>"
    #ps -ef | awk {'print $1"  "$2"  "$3"   "$4"   "$5"   "$7"  "$8'}|less
    ps -eo user,pid,ppid,stime,time,cmd  | head -n 30
    echo "</pre>"
}

drive_space()
{
#echo "<h2>Filesystem space</h2>"
    echo "<pre>"
    df -h
    echo "</pre>"
}


home_space()
{
 #echo "<h2>Home directory space by user</h2>"
    echo "<pre>"
    echo "Bytes Directory"
    #du -sh /home | sort -nr
df -h  --output=source,used,avail /$HOME/
    echo "</pre>"
}
key_directory()
{
echo "Downloads '\n' Directory:"
du -sh $HOME/Downloads

echo "  ;Desktop Directory:"
du -sh $HOME/Desktop
echo "  ;Music Directory:"
du -sh $HOME/Music
}

current_users()
{
#echo "<h2>Current Users Logged in</h2>"
	echo "<pre>"
	who
	echo "</pre>"

}

devices()
{
	#echo "<h2>Devices plugged in</h2>"
	echo "<pre>"
	lsusb
	echo "</pre>"
}

net_interfaces()
{
#echo "<h2>Network interfaces and their states</h2>"
	echo "<pre>"
	ip link | grep state
	echo "</pre>"
}

#### Main


cat <<- _EOF_
  <html>
  <head><meta http-equiv="refresh" content="5"><title>$TITLE</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script type="text/javascript">
\$(document).ready(function(){
	\$('a[data-toggle="tab"]').on('show.bs.tab', function(e) {
		localStorage.setItem('activeTab', \$(e.target).attr('href'));
	});
	var activeTab = localStorage.getItem('activeTab');
	if(activeTab){
		\$('#myTab a[href="' + activeTab + '"]').tab('show');
	}
});
</script>
  </head>

 <body>


<div class="container mt-3">
  <h2>$TITLE</h2> <p>$TIME_STAMP</p>
  <br>
  <!-- Nav tabs -->
  <ul id="myTab" class="nav nav-tabs">
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" href="#home">Current Processes</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" href="#menu1">Current Users</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" href="#menu2">Disk Space</a>
    </li>
<li class="nav-item">
      <a class="nav-link" data-toggle="tab" href="#menu3">Home Space</a>
    </li>
<li class="nav-item">
      <a class="nav-link" data-toggle="tab" href="#menu4">Key Directory Space</a>
    </li>


<li class="nav-item">
      <a class="nav-link" data-toggle="tab" href="#menu5">Devices</a>
    </li><li class="nav-item">
      <a class="nav-link" data-toggle="tab" href="#menu6">Network Interfaces</a>
    </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div id="home" class="container tab-pane active"><br>
      <h3>Current Processes running</h3>
      $(current_process)
    </div>
    <div id="menu1" class="container tab-pane fade"><br>
      <h3>Current Users Logged In</h3>
      $(current_users)
    </div>
    <div id="menu2" class="container tab-pane fade"><br>
      <h3>Drive Space</h3>
      $(drive_space)
    </div>
<div id="menu3" class="container tab-pane fade"><br>
      <h3>Home Directory Memory Space Usage</h3>
      $(home_space)
    </div>
<div id="menu4" class="container tab-pane fade"><br>
      <h3>Key Directory Memory Space Usage</h3>
      $(key_directory)
    </div>
<div id="menu5" class="container tab-pane fade"><br>
      <h3>Devices Plugged In</h3>
      $(devices)
    </div>
	<div id="menu6" class="container tab-pane fade"><br>
      <h3>Network Interfaces and their States</h3>
      $(net_interfaces)
    </div>
  </div>
</div>



  </body>
  </html>
_EOF_

#if [ $temp = 1 ]
#then
exec < mySysMonitor.log
cat > menu.html

#else
#cat > temp.html
#exec > temp.html
#exec < mySysMonitor.html
#cat menu.html >> temp.html
#rm menu.html
#mv temp.html menu.html
#fi


#temp=`expr $temp + 1`

if [ $count = 1 ]
then firefox menu.html
count=`expr $count + 1`
fi

sleep 5

done



