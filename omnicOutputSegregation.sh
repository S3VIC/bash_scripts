#!/bin/bash
# for monitoring invoked commands
set -x

check_file_presence() {
	if [ $1 -gt 0 ]
	then
		mkdir -p $2 && mv *.$3 ./$2 -v
	fi
}


# for checking the presence of
jpg_amount=$(ls | grep .JPG | wc -l)
tif_amount=$(ls | grep .TIF | wc -l)
spa_amount=$(ls | grep .SPA | wc -l)
png_amount=$(ls | grep .png | wc -l)

# directories names
dir_for_jpg="optical"
dir_for_spa="spki"
dir_for_tif="tify"

# extensions
jpg_ext="JPG"
tif_ext="TIF"
spa_ext="SPA"
png_ext="png"

check_file_presence $jpg_amount $dir_for_jpg $jpg_ext
check_file_presence $spa_amount $dir_for_spa $spa_ext
check_file_presence $tif_amount $dir_for_tif $tif_ext

if [ $png_amount -gt 0 ]
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



