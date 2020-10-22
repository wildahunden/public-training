#! /bin/bash
fileName=./junk.txt

source ./generateRandomString.sh

populateFile(){
	rm -f $fileName
	curFileSize=0
	#must prevent this from filling up hard disk.
	maxSize=$(( 1024 * 1024 )) # 1 MiB
	displayMod=1000
	#I could have run a linux command to get the file sieze after each loop
	#  such as  ls -l $fileName | cut -d ' ' -f 5
	#but that would be sloooow!  Just keep track of it here.
	while [ $curFileSize -lt $maxSize ]
	do
	  mod=$(( $curFileSize % $displayMod ))
	  if [ $mod -eq 0 ]
	  then
		  echo $(( $curFileSize * 100 / $maxSize)) " % complete"
	  fi
	  getString
	  #set -x
	  stringSize=${#newString}
	  echo $newString >> $fileName
	  curFileSize=$(( $curFileSize + $stringSize + 1)) 
	  #set +x
	done
	echo " 100% complete"

	#cat $fileName
}

populateFile

#set -x
begLineCount=$(cat $fileName | wc -l)
#echo "begLineCount: " $begLineCount
#echo  "1......"
sort -d -f $fileName > ${fileName}.sorted
#echo  "2......"
sed '/^[aA].*$/d' ${fileName}.sorted > ${fileName}.filtered
#sed '/^[aA]*/d' ${fileName}.sorted  > ${fileName}.filtered
#set -x
endLineCount=$( cat ${fileName}.filtered | wc -l )
#echo "endLineCount:  :$endLineCount:"
#echo  "3......"
linesRemoved=$(( $begLineCount - $endLineCount ))
echo "Lines removed:  $linesRemoved"
#set +x
