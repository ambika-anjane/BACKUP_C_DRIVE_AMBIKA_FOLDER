# String Handling Examples

word1 = 'Coding'
word2 = ' Ninjas'
print(word1 + word2)

print ("----------------------------")

abc = 'Coding'
string = abc.replace('ing', 'ers')
print(abc)
print(string)

print ("----------------------------")

string = 'Coding Ninjas'

# count the character 'i'.
count1 = string.count('a')
print("Count of 'i': ", count1)

# Count spaces.
count2 = string.count(' ')
print("Number of spaces:", count2)

print ("----------------------------")

string = 'Welcome to Coding Ninjas'

# Splitting across the whitespace.

myList = string.split(" ")

print(myList)

print ("----------------------------")

planets = "sun,moon,mercury,venus,mars,jupiter,saturn,raghu,kethu"

print (planets)
print ()

planets_list = planets.split(",")

print (planets_list)

for p in planets_list:
    print (p)

print ("----------------------------")

string = 'Welcome to Coding Ninjas'
index = string.find('N')

print(index)

print ("----------------------------")

xyz = 'Welcome to Coding Ninjas'

# joining the above-given characters of the string with ‘,’.
string = "-".join(xyz)

print(string)

print ("----------------------------")

name = 'Welcome to Coding Ninjas'

place = "CHENNAI"

output1 = name.upper()
output2 = name.lower()
output3 = name.title()
output4 = name.swapcase()
output5 = name.capitalize()
output6 = place.isupper()
output7 = name.islower()
output8 = name.index("a")

print(name)
print(output1)
print(output2)
print(output3)
print(output4)
print(output5)
print(output6)
print(output7)
print(output8)


print ("----------------------------")



