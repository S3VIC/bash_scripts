#!/bin/bash
# for monitoring invoked commands
set -x

#creating directory for optical microscopy images and moving all images to that dir
mkdir -p optical && mv *.JPG ./optical -v 

#creating dir for omnic project files and moving them inside this dir
mkdir -p spki && mv *.SPA ./spki -v 

#removing all previously created spectras with spectraAnalyser (python project)
rm *.png

#creating spectras using spectraAnalyser (y argument allows to create also spectras
#with gal_peaks positions visible on spectra
python3 ~/PycharmProjects/spectraAnalyser/main.py ./ y

#listing all image files names containing gal_peaks positions, sorting them and
#passing that list to a .txt file
ls | grep gal_peaks | sort > sorted_filenames_list.txt

#copying to clipboard sorted filenames list
cat sorted_filenames_list.txt | xclip -selection clipboard



