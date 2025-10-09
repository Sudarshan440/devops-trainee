# user_input = int(input("Enter an Interger: "))

# #checking a number is Even or Odd

# if user_input % 2 ==0:
#     print(f'{user_input} is an Even Number')
# else:
#     print(f'{user_input} is a Odd Number') 

# # Using for loop to print number 1 to user_input number 
# print('numbers from 1 to', user_input)
# for i in range(1,user_input+1):
#     print(i)

###############################################################
from colorama import Fore, Style, init

# Initialize colorama
init(autoreset=True)

user_input = int(input("Enter an Integer: "))

# Checking if the number is Even or Odd
if user_input % 2 == 0:
    print(f'{user_input} is an Even Number')
    print(f'Odd numbers from 1 to {user_input}:')
    for i in range(1, user_input + 1):
        if i % 2 != 0:
            print(i)
else:
    print(f'{user_input} is an Odd Number')
    print(f'Even numbers from 1 to {user_input}:')
    for i in range(1, user_input + 1):
        if i % 2 == 0:
            print(i)
