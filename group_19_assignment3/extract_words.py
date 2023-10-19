import re
from collections import defaultdict
import shutil  # Import the shutil library for file operations

# Specify the path to your novel text file
novel_file_path = 'Dracula.txt'

# Read the novel text file
with open(novel_file_path, 'r', encoding='utf-8') as file:
    novel_text = file.read()

# Split the text into words and preprocess
words = re.findall(r'[a-z]+', novel_text.lower())
word_count = defaultdict(int)

# Count word frequencies
for word in words:
    word_count[word] += 1

# Write to text files
with open('allwords.txt', 'w', encoding='utf-8') as file:
    file.write('\n'.join(words))

with open('uniquewords.txt', 'w', encoding='utf-8') as file:
    unique_words = [word for word, count in word_count.items() if count == 1]
    file.write('\n'.join(unique_words))

with open('wordfrequency.txt', 'w', encoding='utf-8') as file:
    frequency_count = defaultdict(int)
    for word, count in word_count.items():
        frequency_count[count] += 1
    for freq, freq_count in sorted(frequency_count.items()):
        file.write(f"{freq}: {freq_count}\n")

# Define the destination folder path where you want to move the files
a3_novelvisualization_folder = 'a3_novelvisualization'  # Replace with your desired folder path
a3_wordfrequency_folder = 'a3_wordfrequency'  # Replace with your desired folder path
Main_Folder = 'group_19_assignment3'

# Overwrite the files in the destination folder
shutil.copy('allwords.txt', Main_Folder)
shutil.copy('uniquewords.txt', a3_novelvisualization_folder)
shutil.copy('wordfrequency.txt', a3_wordfrequency_folder)
