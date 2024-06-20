# 189. Rotate Array

def func(nums, k):
    while k > 0:
        nums.insert(0,nums[-1])
        nums.pop(-1)
        k-=1

# other solution
# understand the rotation and reminder property:
## if k == len(nums), after rotation there is no change
## if k > len(nums), only k%len(nums) (reminder) steps of rotation would acutally conducted, because the quotient is number of rounds of no change
### and when smaller_number%larger_number, the reminder is the smaller_number itself
## if k < len(nums), easily use slice to do it
k = k%len(nums)
    
nums[:] = nums[-k:] + nums[:-k]