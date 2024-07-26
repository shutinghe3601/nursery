# 45.Jump Game II

def func(nums):
    jump = l = r = 0
    
    while r < len(nums) - 1:
        farthest = 0
        for i in range(l, r+1): # determine the max far
            farthest = max(farthest, i + nums[i])
        l = r + 1
        r = farthest
        jump += 1
        
    return jump