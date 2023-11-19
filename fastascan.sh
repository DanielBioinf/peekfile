#Defining a separator
separator="========================================================================="
#Finding .fasta or .fa files and counting the number of files
if [[ -n $1 ]]; 
    then 
        files=$(find $1 -type f -name "*.fa" -or -name "*.fasta")
    else
        files=$(find . -type f -name "*.fa" -or -name "*.fasta")
    fi

echo $separator
echo GENERAL REPORT FOR ALL FASTA FILES FOUND:

#Reporting number of files
numfiles=$(echo "$files" | wc -l)
echo The number of found files is: $numfiles

#Reporting the number of unique IDs in the files found
numIDs=$(awk '/>/{print $1}' $files | sort | uniq | wc -l)
echo The number of unique fasta IDs across all files is: $numIDs
echo $separator

echo DETAILED REPORT FOR EACH FASTA FILE FOUND:
#Loop through each file
for file in $files
    do
        echo $separator
        echo Filename: $file
        #Test for symbolic links
        if [[ -h "$file" ]]
            then
                echo This file IS a symbolic link
            else
                echo This file IS NOT a symbolic link
        fi
        #How many sequences inside the file. If there is any, calculate some parameters
        numseq=$(awk '/>/{print $0}' $file | wc -l)
        if [[ $numseq -ne 0 ]]
            then    
                echo Number of sequences: $numseq 
                #Total length of all sequences
                seqlength=$(awk '!/>/{gsub(/-/,"",$0); Total=Total+length($0)}END{print Total}' $file)
                echo Total length of all sequences: $seqlength
                #Type of sequence: amino acids or nucleotides
                awk '!/>/{gsub(/[-nN]/,"",$0); print $0}' $file | if grep -q '[^aAcCgGtTuU]'
                                                                            then 
                                                                                echo Type of sequence: Amino acid 
                                                                            else 
                                                                                echo Type of sequence: Nucleotide 
                                                                        fi 

            else
                echo This file has 0 sequences or has inadequate format
        fi
    done