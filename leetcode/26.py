# 26. Remove Duplicates from Sorted Array


unique_lst =[]
for n in nums:
    if n not in unique_lst:
        unique_lst.append(n)   
nums[:] = unique_lst     
len(nums)

# fastest solution
# use continue to skip the duplicated number (process next n directly)
idx = 0
last_unique = None 

for n in nums:
    if n == last_unique: 
        continue
    last_unique = n
    nums[idx] = last_unique
    idx += 1
    
idx