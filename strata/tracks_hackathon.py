# tacks in hackathon

def solution(teamSize_1, teamSize_2, p):
    min_t1 = p/teamSize_1
    min_t2 = p/teamSize_2
    
    if min_t1 == min_t2:
        return min_t1
    else:
        if min(min_t1 + mint_t2) * min_t1 + 1 * min_t2 == p or \
        min(min_t1 + mint_t2) * min_t2 + 1 * min_t1 == p:
            return min(min_t1 + mint_t2) + 1
        else: 
            return -1