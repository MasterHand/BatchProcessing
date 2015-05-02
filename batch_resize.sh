#! /bin/sh
#Bergeron, Andrew
#Project: PA-4
#File: bash_resize.sh
#Instructor: Feng Chen
#Class: cs4103-sp15
#LoginID: cs410305

input_dir="$1"
output_dir="$2"
ratios="$3"

echo $input_dir
helpMe(){
	echo "run '"chmod +x batch_resize.sh"' "
	echo "Arg format: ./batch_resize.sh <input_dir> <output_dir> “[resize ratios]”"
	echo "example: ./batch_resize.sh lfw file_out 50"
	echo "THIS SCRIPT AUTOMATICALLY DELETES REDUNDANT DIRECTORIES"
}

#make the output directory. If the name exists, delete it and write over
mkdir_output(){
if [ -d $output_dir ]; then
	rm -rf $output_dir
	echo "file name '"$output_dir"' already exists."
fi
	mkdir $output_dir
	echo "Overwriting '"$output_dir"' is easier for testing rather than EXIT"
}

#mimic sub directory structure where the images are located
make_output_dir(){
#echo "Make output directory"
#echo "inputfile:" "$input_dir"
#echo "outputfile:" "$output_dir"

for i in $input_dir/*/; do
	#echo "file name: "$i
	mkdir $output_dir/$(basename $i)
	
done
}

#get jpegs and cut file names to insert the ratio identifier
get_to_jpg_files(){

for i in $input_dir/*/; do
TotalFiles=$TotalFiles
oSizeT=$oSizeT
        for img in $input_dir/$(basename $i)/*.jpg; do
	
        echo "File name: "$img
        filename=`echo $img | cut -d '.' -f 1`
        fileext=`echo $img | cut -d '.' -f 2`
        #echo "name:" "${filename}" 
        #echo "ext:" "${fileext}"
	oSize=`wc -c $img | awk '{print $1;}'`
	echo "Size of File: "$oSize
	oSizeT=$((oSizeT+$oSize))

	getFileName=$(basename "$filename")
	noPathFileName="${filename##*/}"
#	echo "no path" "${noPathFileName}"
        output_D=$(getOutputDirOfImg $img)/$noPathFileName
        #echo "output_dir to put image: "$output_D
	
	

                for ratio in $ratios; do
                        #echo "orignal file=" $img
			out_img="$output_D-r$ratio.$fileext"
                        #echo "Resize: "$ratio
			echo "new File:  " $out_img
                        ReSize
                         TotalFiles=$((TotalFiles + 1))
			#convert -resize "$ratio%" $img $out_img
                      # echo "out_img inside ratio loop: "$out_img
                done
        done
done
}

ReSize(){
	newSizeT=$newSizeT
	for f in $output_D/*/; do
	#	echo "image in Resize function=" $img
	#	echo "output_D in Resize function=" $output_D
	#	echo "out_img in Resize function=" $out_img
		convert -resize "$ratio%" $img $out_img
		 newSize=`wc -c $out_img | awk '{print $1;}'`
		echo "Size of New File: " $newSize
		newSizeT=$((newSizeT+$newSize))
	done

}


getOutputDirOfImg(){
	echo $output_dir/$(basename $(basename $(dirname $1)))
}


print_results(){
	#wc -c <file_name> | awk '{print $1}' ---- wc -c gets file in bytes,
	#pipes the pattern on first arg (file_name) and prints bytes size
	#oSizeT=$(du -hs $filename)
	#newSizeT=$(du -h $out_img)
	echo "---------------------------------------------------"
	echo "Total Files: "$TotalFiles
	echo "Total Size of input Files: " $oSizeT
	echo "Total Size of output Files: " $newSizeT
	#printf "%-20s | %-20s | %-5s | %-5s | %-5s | %-5s" $filename $out_img $oSize $newSize $oSizeT $newSizeT
}


if [ "$1" == "help" ]; then
	helpMe
	exit
fi



mkdir_output
make_output_dir
get_to_jpg_files
print_results
