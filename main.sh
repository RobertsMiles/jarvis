# pass in todo.txt, current time, thunderbird integration, etc
# replace todo.txt with recursively scanned obsidian directory

# user input to file
printf ">>> "
read -r input
printf "$input" > temp/argument.txt

# generate date file
printf "The current date and time is: " > temp/date.txt
date +"%I:%M %p, %A %B %d, %Y" >> temp/date.txt
echo >> temp/date.txt

# write all md files to temp file
printf "" > temp/md.txt
for file in $(find files/logseq/journals -type f); do
    #date=${file%.md}
    basename "${file%.md}" >> temp/md.txt
    cat "$file" >> temp/md.txt
    printf "\n\n" >> temp/md.txt
done

# pass instructions ollama and output to file
#cat files/instruction.txt temp/date.txt temp/md.txt temp/argument.txt
cat temp/date.txt temp/md.txt temp/argument.txt | ollama run assistant --keepalive 1m > temp/output.txt

# print output
cat temp/output.txt

# text-to-speech
cat temp/output.txt | flite --setf duration_stretch=1 #0.7

# remove temporary files
rm temp/argument.txt
rm temp/date.txt
rm temp/output.txt
#rm temp/md.txt