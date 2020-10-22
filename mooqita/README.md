# Mooqita challenge for LinuxFoundation Training on EdX

Challenge url:  https://app.mooqita.org/app/solution?challenge_id=YKgnjCTtuD2AoAmu2

To run the script execute "./runit.sh".  it creates 3 files:
-- junk.txt (random strings)
-- junk.txt.sorted (sorted list of strings)
-- junk.txt.filtered (sorted file with rows removed that begin with a or A)

To keep the files small, the code to generate the random file is in the generateRandomString.sh file
which is sourced in the runit.sh file.

Access the random characters happens thousands of time.  To keep it fast, I put all of the possible
characters in a bash array name "validChars."  The number of characters was relatively small and I could
have just typed them all.  But, I wanted to get more experience with assigning characters to arrays, loops,
etc.

Keeping track of the file size is done with a variable in the program.  Since I know exactly how many characters
the program writes, the system can just keep track of it.  I could have used a bash command such as:

fileSize=$(ls -l $fileName | cut -d ' ' -f 5), but that would be significantly slower.

Sorting was done with sort: sort -d -f $fileName > ${fileName}.sorted using the -d for dictionary mode and -f to ignore case.

Filtering rows was done with sed:  sed '/^[aA].*$/d' ${fileName}.sorted > ${fileName}.filtered

The number of lines removed is calculated with the wc -l command before and after the filtering.