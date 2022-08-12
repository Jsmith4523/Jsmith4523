# Get test score from user 

score = eval(input('Enter test score ')) 
 
# You add code to Test if score is
# between 0-100
# and print error message to the user
# "Your score is out of range" if it is not between 0 and 100. 

if score <= -1 or score >= 101:
    print("Your score is out of range")
else: 
    if score <60: 
        print ('F') 
    elif score <70: 
        print ('D') 
    elif score <80: 
        print ('C') 
    elif score <90: 
        print ('B') 
    else: 
        print ('A') 
 
print ('done')  
