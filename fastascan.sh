#Defining a separator
separator="========================================================"
#Finding .fasta or .fa files and counting the number of files
if [[ -n $1 ]]; 
    then 
        files=$(find $1 -type f -name "*.fa" -or -name "*.fasta")
    else
        files=$(find . -type f -name "*.fa" -or -name "*.fasta")
    fi

echo $separator
echo "GENERAL REPORT FOR ALL FASTA FILES FOUND:"

#Reporting number of files
numfiles=$(echo "$files" | wc -l)
echo "The number of found files is: $numfiles"

#Reporting the number of unique IDs in the files found
numIDs=$(awk '/>/{print $1}' $files | sort | uniq | wc -l)
echo "The number of unique fasta IDs across all files is: $numIDs"
echo $separator

echo "DETAILED REPORT FOR EACH FASTA FILE FOUND:"
echo $separator
