num=$(cat $1 | wc -l)
if [[ -n $2 ]]
    then
        if [[ $num -le 2$2 ]]   # I am not sure about the task being asked here(2x)
            then 
                cat $1
            else
                echo "Warning"
                head -n $2 $1
                echo "..."
                tail -n $2 $1
        fi
    else
        if [[ $num -le 23 ]]
            then 
                cat $1
            else
                echo "Warning"
                head -n 3 $1
                echo "..."
                tail -n 3 $1
        fi
fi