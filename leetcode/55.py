# 55.Jump Game
def canJump(nums):
    idx = 0
    fuel = nums[0]
    for i in range(1, len(nums)):
        if fuel == 0: break
        fuel -= 1
        if nums[i] > fuel:
            fuel = nums[i]
        idx = i
    if idx == len(nums) -1 :
        return True
    else:
        return False
        
## faster solution
def fuel(nums):
    fuel = 0
    for n in nums:
        if fuel < 0:
            return False
        if n > fuel:
            fuel = n
        fuel -= 1
    return True
    
# doesn't need to consider the position, image nums are there for fuel, you can iterate nums firectly
        
         