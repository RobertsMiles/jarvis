# pass in todo.txt, current time, thunderbird integration, etc
# replace todo.txt with recursively scanned obsidian directory

# user input to file
printf ">>> "
read -r input
printf "$input" > temp/argument.txt

# generate date file
printf "The current date and time is: " > temp/date.txt
date +"%I:%M %p, %A %B %d, %Y" >> temp/date.txt

# pass files to ollama; output to file; save ollama session
cat files/instruction.txt temp/date.txt files/todo.txt temp/argument.txt | ollama run llama3.2 --keepalive 1m > temp/output.txt

# print output
cat temp/output.txt

# text-to-speech
cat temp/output.txt | flite --setf duration_stretch=0.7

# remove temporary files
rm temp/argument.txt
rm temp/date.txt
rm temp/output.txt