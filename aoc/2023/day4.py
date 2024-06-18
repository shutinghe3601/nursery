import re

f = open('assets/day4.txt')

win_num_card = [] # card_number, winning_number_of_cards
for line in f.readlines():
    cardno_winning, have = line.split('|')
    cardno,winning = cardno_winning.split(':')
    winning_numbers = [int(x) for x in re.findall('\d+', winning)]
    have_numbers = [int(x) for x in re.findall('\d+', have)]
    num_winning = len([x for x in have_numbers if x in winning_numbers])
    win_num_card.append((int(re.findall('\d+', cardno)[0]), num_winning))

# part 1
# sum([2**(x-1) if x > 1 else 1 if x == 1 else 0 for no,x in win_num_card ])

# every card should be processed once
# this dictionary records each card's first process
first_process = {}
for n in range(len(win_num_card)):
    first_process[n+1] = 1

# I was thinking first_process[i+j] += card_num: i
# but it is not, it is += the number of cards (current card itself + its winning cards)
for i, win_copies in win_num_card:
    for j in range(1,win_copies+1):
        # to avoid creating cards at the end
        # for example, if max card_no is 6, we should stop at 6 instead of creating a value for dict[7]
        if i + j <= max([x[0] for x in win_num_card]):
            first_process[i+j] += first_process[i]
    
# part 2
sum(first_process.values())

# explain part 2:
# I have A,B,C,D four cards, and A&B can win one more following card
# In the beginning, dict[each card] should be 1 (its own count)
# then dict[B] += 1 A because A won a B
# then dict[C] += 2 B because A won a B, we have 2 B, and 2 B won 2 C






