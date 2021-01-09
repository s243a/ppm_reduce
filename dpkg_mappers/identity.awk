#!/usr/bin/gawk -f
BEGIN{
  if (length(shuffle_OFS)==0){
    OFS="@@@@"
  } else{
    OFS=shuffle_OFS
  }
  if (length(shuffle_FS)==0){
    FS="|"
  } else {
    FS=shuffle_FS
  }  
  #if (length(group_key)==0){
  #  group_key=1
  #}
  #last_key=""
  #mode="first"
}
{
  if (length($1)>0){
    print $0
  }
}
