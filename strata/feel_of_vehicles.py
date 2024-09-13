# Choosing a fleet of vehicles

def solution(wheels):
    res = []
    for n in wheels:    
        if n%2 == 0:
            n_two = n/2            
            res.append(int(n_two//2 + 1))
            continue
        res.append(0)
    return res
    
print(solution([6,3,2]))        
    