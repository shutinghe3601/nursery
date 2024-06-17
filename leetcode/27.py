def removeElement(nums, val):
#     nums[:] = list(nums)
#     loop = True
#
#     while loop:
#         loop = False
#         for n in nums:
#             if n == val:
#                 nums.remove(n)
#                 loop = True
#                 break
#     return len(nums)

### Fast running time 14ms
# below solution present a reverse mindset, interesting
    index = 0
    for i in range(len(nums)):
        if nums[i] != val:
            nums[index] = nums[i] #1
            index += 1
    return index 

#1 this is needed because it requires output the correct updatd nums
    

nums = [0,1,2,2,3,0,4,2]
val = 2
print(removeElement(nums, val))