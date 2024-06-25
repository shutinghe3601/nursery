# 121. Best Time to Buy and Sell Stock

# hold the min, compute diff

def func(prices):
    bp = prices[0]
    profit = 0
    for i in range(1, len(prices)):
        if prices[i] < bp:
            bp = prices[i]
        if prices[i] > bp:
            diff = prices[i] - bp
            if diff > profit:
                profit = diff
        return profit