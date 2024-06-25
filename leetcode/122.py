# Title: 122. Best Time to Buy and Sell Stock II

def func(prices):
    buy = prices[0]
    profit = 0
    for n in prices:
        if n < buy:
            buy = n
        if n > buy:
            diff = n - buy
            profit += diff
            buy = n
    return profit
    
# other solution
# actually it's one day buy the next day sell, so if the next day is larger than today, then add their diff
def next_day():
    profit = 0
    for i in range(1, len(prices)):
        if prices[i] > prices[i-1]:
            profit += prices[i] - prices[i-1]
    return profit