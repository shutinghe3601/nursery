# 14.Longest Common Prefix

# prefix = first word
# iterate words
    # for i in range(length(min(first letter, prefix)))
        # if prefix[i] start to != word[i], 
            # drop the rest


class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        prefix = strs[0]
        for word in strs:
            wl = len(min(prefix, word))
            prefix = prefix[:wl]
            for i in range(len(prefix)):
                try:
                    if prefix[i] != word[i]: 
                        prefix = prefix[:i]
                except: continue
        if prefix:
            return prefix
        return ''
                    

# another solution
# sort list from shorted word to longest word
# iterate index, if in the beginning first != last one, return ''
# else letter from first one slowly add letters from the last one

class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        prefix = ''
        lst = sorted(strs)
        first= lst[0]
        last = lst[-1]
        for i in range(min(len(first), len(last))):
            if first[i] != last[i]:
                return prefix
            prefix += first[i] # because first one is the shortest 
        return prefix

            