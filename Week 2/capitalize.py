full_name = input()
words = full_name.split()

capitalized_words = [word.capitalize() for word in words]


capitalized_full_name = ' '.join(capitalized_words)

print(capitalized_full_name)