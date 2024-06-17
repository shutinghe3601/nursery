# two algorithms can be consider to replace the `sorted`: Bublle Sort and Selection Sort 

import numpy as np
nums1 = np.array([4,6,5,0,0,0])
nums2 = np.array([1,2,3])
m = 3
n = 3

if n == 0 or nums2 == []:
    nums1[:] = nums1[:m] # nums1 = nums1[:m] is incorrect
elif m == 0 or nums1 == []:
    nums1[:] = nums2[:n]
else:
    nums1[m:] = nums2[:n]

## Learning points:
## - `nums1 = nums1[:m]` only reassign variable `nums1` locally but not affect it passed to the function. To modify a list in-place, always manipulate the list directly, for example `nums1[:] =...`, or use methods that alter the list, for example, pop(), append().

# ### Bubble_sort
# n = len(nums1)
# swap = True
#
# while swap:
#     print(swap)
#     swap = False
#     for i in range(1, n):
#         print(f'now processing {i},{nums1[i-1]} and {nums1[i]}')
#         if nums1[i-1]>nums1[i]:
#             nums1[i-1], nums1[i] = nums1[i], nums1[i-1]
#             swap = True
#         print(nums1)
        
## explaination:
## - swap = True: important because it marks swaps happened between pairs. If swap never altered to True, meaning the array/list already been sorted and the loop can be terminated efficiently
## Why need a while loop?: After swap, some number might inconsistent with swaped pairs, hence need to run over and over again to make sure every numbers are sorted.

### My methods: Select and insert the first number between a pair. Considering repeted numbers by using <= and >=. Remove first and last number in the end because they are duplicated.
lo = nums1.copy().tolist()
lst = [min(nums1), max(nums1)]

# print('original: ',lo)

while lo != []:
    
    for i in range(len(nums1)):
        # print('i: ', i)
        for j in range(1,len(lst)):
            if lst[j-1] <= nums1[i] <= lst[j]:
                lst.insert(j, nums1[i])
                # print('lst: ', lst)
                lo.pop(0) # always pop the first one becuase it has been compaired
                # print('lo: ',lo)
                break
    
# print('final lst:', lst)
nums1[:] = np.array(lst[1:-1])

print(f'result: {nums1}')

            
