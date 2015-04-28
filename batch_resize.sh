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
	echo "Arg format: ./batch_resize.sh <input_dir> <output_dir> “[resize ratios]”"
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

copy_input_to_outfile(){
echo "inputfile:" "$input_dir"
echo "outputfile:" "$output_dir"

#mv $input_dir/*/*jpg "$output_dir"
#cp -r $input_dir "output_dir"
for i in $input_dir/*/; do
	echo $i
	mkdir $output_dir/$(basename $i)
	for pic in $input_dir/$(basename $i)/*.jpg; do
		echo $pic
		#call resize function here and remove cp cmd
		cp $pic $output_dir/$(basename $i)/

	done
done


}
resize_image(){


}



if [ "$1" == "help" ]; then
	helpMe
	exit
fi



mkdir_output
copy_input_to_outfile
resize_image


