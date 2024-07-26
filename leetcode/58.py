# 58. Length of Last Word

class Solution:
    def lengthOfLastWord(self, s: str) -> int:
        # initial solution
        ss = s.split(' ')
        a = [w for w in ss if w != '']
        return len(a[-1])
    
        # better solution
        ss = s.strip().split()
        
        # following condition checks if the list words is empty. The expression not words is True when words is an empty list.
        if not ss: 
            return 0
        return len(ss[-1])