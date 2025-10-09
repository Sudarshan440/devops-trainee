# fruits = ['apple','mango','grapes']
# for x in fruits:
#     print(x)

# count = 0
# while count < 5:
#     print(count)
#     count += 1

# for i in range (10): #circle bracket = it start with zero
#     if i == 5:
#         break
#     print(i) # 0 1 2 3 4 

# for i in range (10): #circle bracket = it start with zero
#     if i == 5:
#         continue
#     print(i) #  1 2 3 4 6 7 8 9 10

########### Loop With dictionary ################

# person = {'name':'sudarshan', 'age':'25', 'city' : 'indore' }

# for key,value in person.items():
#     print(f'{key}:{value}') # f => imbeding key value in string

########### Loop Control with ELSE ###############

for i in range (5):
    if i == 3:
       break # (else not showing after using break)
    print (i)
else:
    print ('loop completed without a break')

