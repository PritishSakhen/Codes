import asyncio as a#1-as
#False, None, True, notice t,n,f capitals
#break, continue
#int b,a and int b=0 doesn't work in python
class myfunctions:
    @staticmethod #This tells Python that these functions belong to the class namespace but don't require an instance
    async def fetch_data_from_internet():   
        print("Starting download...")
    #No, await does not work inside a normal def
    # 'await' pauses this function for 3 seconds, letting Python do other work.
    # It waits for the simulated download (asyncio.sleep) to finish.
       # await a.sleep(2)
    @staticmethod
    async def hello():#doesn't function line by line; works together due to async
        a_var="Hello"
        b="Hello my"
        if a_var and b:
            print("Input is same or true")
        else: #this else is not indentated
         print("Input is different or false")
#prints true but if a and b were hello and hello my, it would be false
        c=int(input()) #has to be int(input()) not input(), coz assert is initialised for an int input
        assert -1<c<100 #stops program if false
        del a_var,b,c #saves space
async def main():
     await myfunctions.fetch_data_from_internet()
     await myfunctions.hello()
#a.run(fetch_data_from_internet())# can't take 2 functions
#a.run(keywords())
a.run(main())
var=myfunctions()





