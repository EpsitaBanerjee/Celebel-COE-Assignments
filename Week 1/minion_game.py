def minion_game(string):

    kevin_score = 0
    stuart_score = 0
    
  
    string_length = len(string)
    

    vowels = 'AEIOU'
    
   
    for i in range(string_length):
        if string[i] in vowels:
            kevin_score += string_length - i
        else:
            stuart_score += string_length - i
    
   
    if kevin_score > stuart_score:
        print("Kevin", kevin_score)
    elif kevin_score < stuart_score:
        print("Stuart", stuart_score)
    else:
        print("Draw")


s = input()
minion_game(s)