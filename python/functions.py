# def even(num):
#     return num % 2 == 0
# def odd(num):
#     return num % 2 != 0
# def square(num):
#     return num ** 2

# #Test the Function
# num = int(input ('Enter any Integer: '))
# if even(num):
#     print(f'{num} is a even number')
# else:
#     print(f'{num} is a odd number')

# print(f'The Square of {num} is {square(num)}')


############## Function with Default Value ##################

def greet(name="Friend"):
    print(f"Hello {name}, nice to meet you!")
greet()
input_name= input('enter your name: ')
def greet(input_name):
    print(f"Hello {input_name}, nice to meet you!")
greet() #ERROR 
greet(input_name)
greet('Sudarshan')
