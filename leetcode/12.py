# 12.Integer to Roman


def intToRoman(num: int) -> str:
    dic = {1:'I',5:'V',10:'X',50:'L',100:'C',500:'D',1000:'M'}
    strn = str(num)
    r = ''
    for n in range(len(strn)):
        t = len(strn) - (n+1)
        if int(strn[n]) == 9:
            r += dic[10**t]+dic[10*(10**t)]
        elif int(strn[n]) == 4:
            r += dic[10**t]+ dic[5*(10**t)]
        elif int(strn[n]) >= 5:
            r += dic[5*(10**t)] + (int(strn[n])-5)*dic[(10**t)]
        else:
            r += int(strn[n]) * dic[10**t]
    return r

num = 1994
print(intToRoman(num))