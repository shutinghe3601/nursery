# 80. Remove Duplicates from Sorted Array II
idx = 0
count = 1
last = None
for n in nums:
    if n == last:
        count += 1
    else:
        count = 1
    if count > 2: # when reach count > 2, skip
        continue
    last = n
    nums[idx] = n
    idx += 1
return idx

# more elegant and faseter method:
index = 2
last_match = nums[0]
for i in range(2, len(nums)):
    if nums[i] != last_match: # unique, process
        if nums[i] == nums[i-1]: # if already have 1
            last_match = nums[i] # update last_match
        nums[index] = nums[i]
        index += 1
return index

# above method is fundementally different than mine. It compares three numbers are the same time, because:
# 1. No matter what, first two numbers will be remained
# 2. As long as the third number is different than the first one, then it's OK (even it's same as the second)
# Changing last_match when nums[i] == nums[i-1] because nums[i] == nums[i-1] is reaching maximum repetitive numbers, hence need to update the last_match