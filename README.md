# TOOBIN-SWITCH
this is a OBS LUA script to prevent accidental livestreams. It creates a notification sound when going live on OBS, switches to a "warning" scene, and if the scene is not changed before the timer runs out, the livestream is automatically stopped.

To use this file:  
unzip files into the scripts folder of OBS.  
load "TOOBIN SWITCH", "obsnotification" and "playsound" into OBS scripts.  
select which warning scene you'd like to see when starting your livestream from the dropdown in "obsnotification"  
here you may also change the notification sound you hear when going live or stopping your livestream  
  
now we're going to create the timer to stop the livestream.  
create a text source in your livestream warning scene.  
in the TOOBIN SWITCH script, change the timer source to that new text source.  
input how long you'd like your livestream timer to be.  

now when you press "Start Streaming" the scene will automatically change to your warning scene.  
Unless you click off and select another scene before the timer runs out, the livestream will be automatically stopped!
