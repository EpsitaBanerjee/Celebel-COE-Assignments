from itertools import combinations

def calculate_probability():
   
    n = int(input())
    letters = input().split()
    k = int(input())
    
    
    comb_list = list(combinations(letters, k))
    
   
    count_a = sum(1 for combo in comb_list if 'a' in combo)
    
   
    probability = count_a / len(comb_list)
   
    print(f"{probability:.12f}")


calculate_probability()
