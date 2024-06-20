#  1. Two Sum

def func(nums, target):
    for i in range(len(nums)):
        for j in range(i + 1,len(nums)):
            if target - nums[i] == nums[j]:
                return i,j
                

def faster_func(nums, target):
    for i in range(len(nums)):
        try:
            sec = nums.index(target - nums[i])
        except: continue
        if sec != i:
            return i, sec
            
# other faster solution, using dic
# store the idx of [target-first_num] directly to the dic
d = {}
for i,x in enumerate(nums):
    if x in d:
        return [i,d[x]]
    d[target-x] = i