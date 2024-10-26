# pass in todo.txt, current time, thunderbird integration, etc

# user input file
printf "You:\n"
read -r input
echo "$input" > argument.txt

# generate date file
printf "The current date and time is: " > date.txt
date +"%I:%M %p, %A %B %d, %Y" >> date.txt

# pass files to llm
printf "\nAssistant:\n"
cat instruction.txt date.txt todo.txt argument.txt | ollama run llama3.2

# remove temporary files
rm argument.txt
rm date.txt