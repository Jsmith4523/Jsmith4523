#Generating list for both all and even
listing = []
evenlist = []

#creating the range of ten to ask for the input
for i in range(10):
    #This is a new thing i remember learning about with C and didn't know it was
    #Possible in python: we can get what number we are currently at in range and
    #assign it within the input. I had trouble trying to get all numbers at once.
    #So this helps see what index  you are in with %d out of 10 with %i
    #We then append that number to the list and repeat
    Inputting = int(input("Enter 10 numbers. This is index %d of 9: " %i))
    listing.append(Inputting)

#We repeat similar steps are before.
#Except, we are now modulus dividing to see if the results
#To see if the remainder does not equal zero
#if not, they are even numbers and are appended to the evenlist.
for i in range(10):
    if listing[i]%2 != 0:
        evenlist.append(listing[i])

#Instead of prinitng multiple lines
#we can print all-in-one by spltting by new lines
print("Here's the entire list of numbers:\n", listing, "\nAnd here's the even list:\n", evenlist)
