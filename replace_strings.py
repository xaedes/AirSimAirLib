
import sys

search_term_file = sys.argv[1]
replace_term_file = sys.argv[2]
targets_file = sys.argv[3]

print("search_term_file",search_term_file)
print("replace_term_file",replace_term_file)
print("targets_file",targets_file)

def strip_lines(lines):
    return [line.strip() for line in lines]

with open(search_term_file, 'r') as file:
    search_terms = strip_lines(file.readlines())

with open(replace_term_file, 'r') as file:
    replace_terms = strip_lines(file.readlines())

with open(targets_file, 'r') as file:
    targets = strip_lines(file.readlines())

replacements = list(filter(lambda x: x[0] != "",zip(search_terms, replace_terms)))

for target in targets:
    with open(target, 'r') as file:
        content = file.read()

    for search_term, replace_term in replacements:
        content = content.replace(search_term, replace_term)

    with open(target, 'w') as file:
        file.write(content)

