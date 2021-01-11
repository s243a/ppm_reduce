#!/usr/bin/gawk -f
function match_arch(field){
              switch (field){
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
}
{  #f1=pkgfile_noExt     |f2=arch        |f3=ver     |f4=pkgfile               |f5=dir_name                   |f6=filelist                     |f7=md5sum                       |pkg
	#adb_8.1.0+r23-5_i386|               |8.1.0+r23-5|adb_8.1.0+r23-5_i386.deb |packages                      |adb_8.1.0+r23-5_i386.files      |                                |adb
    #adb_8.1.0+r23-5     |               |           |                         |packages|adb_8.1.0+r23-5.files                                 |00fe8bb85ae24f00fff63bdfbd9464ea| 
  #filelist "|" md5sum "|" dir_name "|" pkg "|" arch "|" ver "|" pkgfile
  #split($0, lines , FS)
  pkg=""; arch=""; ver=""; pkgfile=""; f5=dir_name=""; f6=filelist=""; md5sum=""; pkgfile_noExt=""
  for(i=1; i<=NF; i++){
    line=$i
    
    #print "line=" line
    split(line, fields , OFS)
      if (length(pkgfile) == 0){
        pkgfile=fields[4]
      }    
    if ( length(filelist) == 0 ){
      filelist=fields[6]
    }              
       if ( length(arch) == 0 ){
          if (length(fields[2]) != 0){
            arch=fields[2]          
          } else {
            if ( length(pkgfile) != 0 ){
              arch=gensub(/^(.+_.+_)(.+)([.]deb)$/,"\\2","g",pkgfile)
              if ( length(arch) == 0 ){
                arch=match_arch(pkgfile)           
              }
            } else if ( filelist != 0 ){
              arch=match_arch(filelist)
            }     
        }
      }

       
    if ( length(pkg) == 0 ){
      pkg=fields[8]
    }
    if ( length(ver) == 0 ){
      ver=fields[3]
    }
    if ( length(dir_name) == 0 ){
      dir_name=fields[5]
    }      

    if ( length(md5sum) == 0 ){
      md5sum=fields[7]
    }   
    if ( length(pkgfile_noExt) == 0 ){
      pkgfile_noExt=fields[1]
    }                         
  }
    #We don't need to do the following since it is the key. 
    #if ( length(pkgfile_noEx) == 0 ){
    #  pkgfile_noExt=pkgfile
    #  pkgfile_noExt=sub(/\.[^.]+$/, "", pkgfile_noExt)
    #}    
    if ( length(pkg) == 0 ){
      pkg=pkgfile_noExt
    }  
  print pkg, arch, ver, pkgfile, dir_name, filelist, md5sum,pkgfile_noExt 
}
#fonts-arphic-gbsn00lp_2.11-15_all||2.11-15|fonts-arphic-gbsn00lp_2.11-15_all.deb|packages|fonts-arphic-gbsn00lp_2.11-15_all.files||fonts-arphic-gbsn00lp
