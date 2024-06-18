# Majority Element

def func():
    count = 1
    last = None
    for n in sorted(nums): # [3,2,3] -> [2,3,3]
        if n == last:
            count += 1
        last = n
        if count > len(nums)/2:
            return n
            
# faster solutions()
def candidate_func():
    count = 0
    candidate = 0
    
    for n in nums:
        if count == 0: # *
            candidate = n 
        
        if num == cadidates:
            count += 1
        else:
            count -=1 # **
            
    return candidate 

# * when n != candidate, count -= 1, so when count = 0, meaning the amount of current candidate is not exceeding half of len(nums), hence need to change the candidate
# ** why there is no count > len(nums)/2 sort of things? Becuase count doesn't need to be higher than len(nums)/2, the majority element should always more than others, as long as count != 0, meaning the current cadidate is the marjority number
# this is a very interesting solution, the mindset kinda jump out of the box -- considering the property of majority instead of simply comparing with len(nums)/2...

         

            