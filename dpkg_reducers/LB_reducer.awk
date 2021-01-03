#!/usr/bin/gawk -f
BEGIN {
    if (length(shuffle_OFS)>0){
      FS=shuffle_OFS
    } else
    {
      FS="@@@@"
    }
    if (length(shuffle_FS)>0){
      OFS=shuffle_FS
    }  else {
      OFS = "|"
    }
  pkg=""; arch=""; ver=""; pkgfile=""; f5=dir_name=""; f6=filelist=""; md5sum=""
}
{
  #split($0, lines , FS)
  for(i=1; i<=NF; i++){
    line=$i
    pkg=""; arch=""; ver=""; pkgfile=""; f5=dir_name=""; f6=filelist=""; md5sum=""
    #print "line=" line
    split(line, fields , OFS)
    if ( length(pkg) == 0 ){
      pkg=fields[1]
    }
    if ( length(arch) == 0 ){
      arch=fields[2]
      sub(/$[:]/, "",arch)
    }
    if ( length(ver) == 0 ){
      ver=fields[3]
    }
    if ( length(pkgfile) == 0 ){
      pkgfile=fields[4]
    } 
    if ( length(dir_name) == 0 ){
      dir_name=fields[5]
    }      
    if ( length(filelist) == 0 ){
      filelist=fields[6]
    }   
    if ( length(md5sum) == 0 ){
      md5sum=fields[7]
    }   
                      
  }
  print pkg, arch, ver, pkgfile, dir_name, filelist, md5sum 
}

