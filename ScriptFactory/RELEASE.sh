#!/bin/sh

# This script is intended to 
# 'tangle' current state of gen-* files to separate folder 
# together with necessary data to run it.
#
# This script need:
# - to provide proper folder structure so that relative paths
#   in release scripts are correct and will not overwrite sth !
#
# Micha� Konrad Komorowski, August 2018

release_name="v1_examplary"




# ########################################################################


read -p "Do you really want to release ${release_name}? [Y/n] " response
case $response in [yY][eE][sS]|[yY]|[jJ]|'') 
		      echo OK - release will be created.
		      ;;
		  *)
		      echo Canceled.
		      exit 1;
		      ;;
esac

echo Entering releases folder ...
cd releases

if [ -d "$release_name" ]
then
   echo 'Release already exist !'
   read -p  'Do you want to overwrite this release? [Y/n]' response
   case $response in [yY][eE][sS]|[yY]|[jJ]|'') 
			 echo OK - release will be overwritten.
			 ;;
		     *)
			 echo Canceled.
			 cd ..
			 exit 1
			 ;;

   esac
fi		     
		     
# prepare folder structure
echo Creating folder $release_name ...
rm -rf $release_name
mkdir $release_name
echo Going inside ...
cd $release_name
echo Creating scripts, output and figures folders ...
mkdir scripts
mkdir output
mkdir output/fig
echo Going back x2 ...
cd ../../

# generate scripts
echo Creating scripts ...
cp gen_scripts/*.m releases/$release_name/scripts/.

# add arbitrary comments to the info.txt file
echo Adding info.txt file ... 
cat >releases/${release_name}/info.txt <<EOF
This is first version of the script.
Ordinary sines. Made for the sake of example.

"Use the force!"

EOF

echo Everything successfully done !

#########################################################
