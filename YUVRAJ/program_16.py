#Dictionary Example

chess = {'king': 1, 'queeen': 2, 'bishop': 3, 'horse': 4, 'elephant' : 5, 'pawn': 6}

planets = {'SUN': 1, 'MOON': 2, 'MERCURY': 3, 'VENUS': 4, 'MARS': 5, 'JUPITER' : 6, 'SATURN': 7, 'RAGHU': 8, 'KETHU': 9}

planetsintamil = {'சூரியன்': 1, 'சந்திரன்': 2, 'புதன்': 3, 'சுக்ரன்': 4, 'செவ்வாய்': 5, 'குரு' : 6, 'சனி': 7, 'ராகு': 8, 'கேது': 9}


planetsengandtamil = {'SUN': 'சூரியன்', 'MOON': 'சந்திரன்', 'MERCURY': 'புதன்', 'VENUS': 'சுக்ரன்', 'MARS': 'செவ்வாய்' , 'JUPITER' : 'குரு', 'SATURN': 'சனி', 'RAGHU': 'ராகு', 'KETHU': 'கேது' }





print ("-------------")

print (chess["king"])
print (chess["queeen"])
print (chess["bishop"])
print (chess["horse"])
print (chess["elephant"])
print (chess["pawn"])

print ("-------------")


print (planets["SUN"])
print (planets["MOON"])
print (planets["MERCURY"])
print (planets["VENUS"])
print (planets["MARS"])
print (planets["JUPITER"])

print ("-------------")

for k in chess:
  print('k =', k)

print ("-------------")

for k in planets:
  print('k =', k)

print ("-------------")



for k, v in chess.items():
  print('k =', k, ', v =', v)


print ("-------------")


for k, v in planets.items():
  print('k =', k, ', v =', v)


print ("-------------")


for k, v in planets.items():

  if (k=='MOON') or (k=='JUPITER') or (k=='VENUS') or (k=='MERCURY'):
     print(k, ' is a Auspicious Planet')
  elif (k=='SUN') or (k=='MARS') or (k=='SATURN') or (k=='RAGHU') or (k=='KETHU'):
     print(k, ' is a Malefic Planet')


print ("-------------")


for k, v in planets.items():

  if (k=='MOON') or (k=='JUPITER') or (k=='VENUS') or (k=='MERCURY'):
     print(k, ' - சுப கிரகம்')
  elif (k=='SUN') or (k=='MARS') or (k=='SATURN') or (k=='RAGHU') or (k=='KETHU'):
     print(k, ' - பாவ கிரகம்')



print ("-------------")


for k, v in planetsintamil.items():
  print('k =', k, ', v =', v)


print ("-------------")


for k, v in planetsintamil.items():

  if (k=='சந்திரன்') or (k=='குரு') or (k=='சுக்ரன்') or (k=='புதன்'):
     print(k, ' - சுப கிரகம்')
  elif (k=='சூரியன்') or (k=='செவ்வாய்') or (k=='சனி') or (k=='ராகு') or (k=='கேது'):
     print(k, ' - பாவ கிரகம்')



print ("-------------")

for k, v in planetsengandtamil.items():
  print('k =', k, ', v =', v)











