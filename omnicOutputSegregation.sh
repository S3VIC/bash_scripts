#!/bin/bash
# for monitoring invoked commands
set -x

# checking for presence of JPG images
jpg_amount=$(ls | grep .JPG | wc -l)
tif_amount=$(ls | grep .TIF | wc -l)
spa_amount=$(ls | grep .SPA | wc -l)
png_amount=$(ls | grep .png | wc -l)

if [ jpg_amount -gt 0 ]
then
	#creating directory for optical microscopy images and moving all images to that dir
	mkdir -p optical && mv *.JPG ./optical -v 
fi

if [ spa_amount -gt 0 ]
then
	#creating dir for omnic project files and moving them inside this dir
	mkdir -p spki && mv *.SPA ./spki -v 
fi

if [ png_amount -gt 0 ]
then
	#removing all previously created spectras with spectraAnalyser (python project)
	rm *.png
fi
#creating spectras using spectraAnalyser (y argument allows to create also spectras
#with gal_peaks positions visible on spectra
python3 ~/PycharmProjects/spectraAnalyser/main.py ./ y

#listing all image files names containing gal_peaks positions, sorting them and
#passing that list to a .txt file
ls | grep gal_peaks | sort > sorted_filenames_list.txt

#copying to clipboard sorted filenames list
cat sorted_filenames_list.txt | xclip -selection clipboard



