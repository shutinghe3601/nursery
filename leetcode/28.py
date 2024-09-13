# 28.Find the Index of the First Occurrence in a String

class Solution:
    def strStr(self, haystack: str, needle: str) -> int:
        lst = haystack.split(needle)
        if lst != [haystack]:
            first = len(lst[0])
            if first == 0: return first
            return first

        return -1
        
        # Second solution
        return haystack.find(needle)