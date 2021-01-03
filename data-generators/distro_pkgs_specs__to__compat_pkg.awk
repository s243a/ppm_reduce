#!/usr/bin/gawk -f
BEGIN {FS="|"
	   mode="parse_var"}
/PKGS_SPECS_TABLE=[[:space:]]*$/ {mode="PKGS_SPECS_TABLE";next}
/'[[:space:]]*$/ {mode="parse_var"; next} 
{
if ($1 == "yes"){
	  if (length($3)==0){
		print $2 "|" $2  
	  } else {
		  split($3, pkgs , ",")
		  for (a_key in pkgs){
		    print pkgs[a_key] "|" $2 
	      }
	  }
	}
}
