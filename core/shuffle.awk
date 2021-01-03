#!/usr/bin/gawk -f
BEGIN {
  if (length(shuffle_FS)>0){  
     FS=shuffle_FS
  } else {
    FS="|"
  }
  if (length(shuffle_OFS)>0){
    bla=shuffle_OFS
  } else
  {
    bla="@@@@"
  }
  if ( length(Keep_Key) == 0){
    Keep_Key=false
  }
  OFS=""
}
{
  #print "FS=" FS
  #print "key=" key
  #print "$1=" $1
  if($1 == key) {
    if ( Keep_Key != "true" ){
      $1 = ""
    }
    printf "%s%s", bla, $0
    
  } else { 
    if(NR > 1) {
      print ""
    }
    printf "%s", $0
    key = $1
  }
} END {
  print ""
}
