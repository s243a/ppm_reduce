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
  #filelist "|" md5sum "|" dir_name "|" pkg "|" arch "|" ver "|" pkgfile
  #split($0, lines , FS)
  for(i=1; i<=NF; i++){
    line=$i
    pkg=""; arch=""; ver=""; pkgfile=""; f5=dir_name=""; f6=filelist=""; md5sum=""
    #print "line=" line
    split(line, fields , OFS)
     if ( length(arch) == 0 ||  length(pkgfile) == 0 ){
      if ( length(arch) == 0 ){
        if (length(fields[2]) == 0){
          if ( length(fields[4]) != 0 ){
            arch=gensub(/^(.+_.+_)(.+)([.]deb)$/,"\\2","g",$4)
            if ( length(arch) == 0 ){
              switch (fields[7]){
              case /[_\-.]i686[_\-.]/:
                 #arch="i686"; break
              case /[_\-.]i586[_\-.]/:
                 #arch="i586"; break
              case /[_\-.]i486[_\-.]/:
                 #arch="i486"; break                                               
              case /[_\-.]i386[_\-.]/:
                 arch="i386"; break
               case /[_\-.]x86_64[_\-.]/:
                 #arch="x86_64"; break                
              case /[_\-.]amd64[_\-.]/:
                 arch="amd64"; break
              case /[_\-.]amd64[_\-.]/:
                 arch="amd64"; break
              case /[_\-.] armhf[_\-.]/:
                 arch="armhf"; break 
              case /[_\-.]armel[_\-.]/:
                 arch="armel"; break
              default:
                arch=""; break 
              }           
            }
          }
        } else {
          arch=fields[5]
          sub(/$[:]/, "",arch)       
        }
      }
      if (length(pkgfile) == 0){
        pkgfile=fields[7]
      }
    }
       
    if ( length(pkg) == 0 ){
      pkg=fields[4]
    }
    if ( length(ver) == 0 ){
      ver=fields[6]
    }
    if ( length(dir_name) == 0 ){
      dir_name=fields[3]
    }      
    if ( length(filelist) == 0 ){
      filelist=fields[1]
    }   
    if ( length(md5sum) == 0 ){
      md5sum=fields[7]
    }   
                      
  }
  print pkg, arch, ver, pkgfile, dir_name, filelist, md5sum 
}

