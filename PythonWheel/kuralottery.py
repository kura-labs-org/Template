#Replacement for wheel of anxiety.

#Anxiety will be added at a later date. 
import random
import time
import sys

animation = "|/-\\"
lottery = True

with open('./kuralotterybank.txt', 'r') as file:
    data = file.read().split('\n')
    # print(random.choice(data))
    while lottery == True:
        option = input("Do you wish to pick a vic- I mean winner? Y/n").lower()
        if option == "y":
            for i in range(20):
                time.sleep(0.1)
                sys.stdout.write("\r" + animation[i % len(animation)])
                sys.stdout.flush()
            victim = random.choice(data)
            print(f"Congratulations, {victim}, You are the winner!!")
            option = input("Would you like to remove this person from the lottery pool? Y/n").lower()
            if option == "y":
                data.remove(victim)
            option = input("Would you like to exit? Y/n").lower()
            if option == "y":
                print("Have a nice day!")
                lottery = False
        else:
            exit()
with open("kuralotterybank.txt", "w") as file:
    for i in data:
                file.write("%s\n" % i)
