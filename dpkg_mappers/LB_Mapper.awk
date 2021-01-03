#!/usr/bin/gawk -f
BEGIN{
  if (length(shuffle_OFS)==0){
    OFS="@@@@"
  }
  if (length(shuffle_FS)==0){
    FS="|"
  }  
  if (length(group_key)==0){
    group_key=1
  }
  last_key=""
  mode="first"
}
{
  if (length($group_key)>0){
    print $group_key , $0
  }
}
