#! /bin/bash

#Default max length of the generated string is 15 but allow a different size.
maxStringLen=15
declare -a validChars

#set up an array of characters for the string
addIntegersToArray() {
	#add integers 0 - 9 to the array as strings
	j=0
	while [ $j -lt 10 ]
	do
	  n=$(printf $j)
	  #echo $n
	  validChars+=("${n}")
	  j=$((j + 1))
	done
}

#add ascii chars to array based on ascii code
addCharsToArray() {
	startAscii=$1
	pos=0
	while [ $pos -lt 26 ]
	do
	  octal=$(printf '\\%03o' $((startAscii + pos)))
	  ascii=$(printf '%b' $octal)
	  validChars+=("${ascii}")
	  pos=$(( $pos + 1))
	done
}

populateCharArray(){
 	addIntegersToArray
	addCharsToArray 65
	addCharsToArray 97
}


getString(){
	#was a parm passed in?
	if [[ $# > 0 ]] 
	then
	  #is the first parm a number
	  [ -n "$1" ] && [ "$1" -eq "$1" ] 2>/dev/null
	  if [ $? -eq 0 ]; then
	    #the parm is number, change the default max lenagth
	    maxStringLen=$1
	  fi
	fi

	arrayLen=${#validChars[@]}
	newString=""
	j=0
	while [ $j -lt $maxStringLen ]
	do
	  newChar=$(($RANDOM * $arrayLen / 32767))
	  newString="$newString${validChars[$newChar]}"
	  j=$(( j + 1 ))
	done

}

populateCharArray

#getString 32
#USAGe:  
#  getString {lengthOfStringToReturnDefault15}
#  echo $newString
