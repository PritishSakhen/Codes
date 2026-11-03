#type copilot in terminal, check offical documentation for entire guide
import keyword
import asyncio as a
import sys#1-as
#False, None, True, notice t,n,f capitals
#break, continue, for, from, while, use with keyword in json
#int b,a and int b=0 doesn't work in python
class myfunctions:
    blah="Input is same or true"
    @staticmethod #This tells Python that these functions belong to the class namespace but don't require an instance
    async def fetch_data_from_internet():   
        print("Starting download...")
    #No, await does not work inside a normal def
    # 'await' pauses this function for 3 seconds, letting Python do other work.
    # It waits for the simulated download (asyncio.sleep) to finish.
        add_ten = lambda x: x + 10
        print("Your age is:" + str(add_ten(int(input("Enter your age: ")))))#lambda function, takes input and adds 10 to it
        await a.sleep(2)
        def nonlocal_func():
            nonlocal add_ten
            add_ten = lambda x: x + 20
            print("Your age is:" + str(add_ten(int(input("Enter your age: ")))))#lambda function, takes input and adds 20 to it 
            # 👇 YOU NEED TO CALL IT HERE SO IT ACTUALLY RUNS!
        nonlocal_func() 
        return# without this staticmethod line has an error which is line 24      
    @staticmethod
    async def hello():#doesn't function line by line; works together due to async
        a_var="Hello"
        b="Hello my"
        c="k"
        if a_var and b and a_var is b:
            global blah
            print(blah)
        elif  a_var and b or a_var is b:#no indentation 
                print("Input is same or true")
        elif c in a_var:
                   raise ValueError("k IN Hello")
        else: #this else is not indentated
         print("Input is different or false")
        #yield "Moving on to next function"
#prints true but if a and b were hello and hello my, it would be false
        c=int(input()) #has to be int(input()) not input(), coz assert is initialised for an int input
        assert -1<c<100, "'tis bellow -1 and 100"#stops program if false, print 'tis when assertion fails
        del a_var,b,c #saves space
        try:
          result = 10 / 0
        except ZeroDivisionError:
            print("Caught an error: Cannot divide by zero!")
        finally:
             print("This block always runs, regardless of an error.")
        return #stops function completely, but yield stops functions and then continues it, return None can be written for normal def but here shows error
async def main():
     await myfunctions.fetch_data_from_internet()
     await myfunctions.hello()
#a.run(fetch_data_from_internet())# can't take 2 functions
#a.run(keywords())
a.run(main())
a.run(myfunctions.hello())
var=myfunctions()
#END OF KEYWORDS
#-----------------------------------------------------------------------------------------------------------------
#ALL STRING METHODS AND PREFIXES
#combination of prefixes uses: rb, rf or fr, rb, rt, ur, fb, ft)
print(
    f"Topic: Python", 
    "Multithreading", r"\n", u"Unicode", b"Bytes", t"T-string",
    F"Version: {sys.version.split()[0]}",
    sep=" | ",                      # 1. Custom separator between objects
    end=" [COMPLETED SUCCESSFULLY]\n", # 2. Custom ending string instead of a newline
    #file=log_buffer,                # 3. Redirecting output to a file-like stream object
    flush=True                      # 4. Forcing an immediate buffer flush to the stream
)
s=str(input("Enter a string: "))
s3=s.split()
s1=s.upper()
s2=s.lower()
print(f"Uppercase: {s1}, Lowercase: {s2}")
#---‐----------------‐-------------
#Dunder methods, objects, instances
