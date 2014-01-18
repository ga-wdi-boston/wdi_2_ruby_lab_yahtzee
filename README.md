# Yahtzee!

Yahtzee is a simple dice game that involves rolling five ordinary 6-sided dice. For each roll the player declares a category, such as ones, twos, sixes, pair, two pairs, etc. The roll is scored based on the rules for that category. Once chosen, a category cannot be chosen again for the rest of the "round", adding some strategy to the game.

## Objective

Your goal in this lab is to use test-driven development and pair programming to write a `YahtzeeRoll` class, representing a single roll of five 6-sided dice that can be scored in a given category. **Your code will not perform the actual dice roll, nor will it keep track of multiple rolls.** We are not simulating the entire game of Yahtzee.

`YahtzeeRoll` should be initialized with values for the dice. It should check the roll for validity, and if it is not valid, raise an error. You should be able to call a scoring method on the `YahtzeeRoll` object that accepts a category and returns the score of the roll according to the rules of that category. If the category passed to the scoring method is not applicable to the roll (e.g. "pair" with a roll that has no pairs), it should be scored as 0 points.

```
> roll = YahtzeeRoll.new(5, 4, 6, 2, 4)
> roll.score(:pair) # should return 8
```

The above code is merely an example &ndash; the details of the implementation are entirely up to you.

## Scoring Categories

* **Ones**, **Twos**, **Threes**, **Fours**, **Fives**, **Sixes**: Score the sum of the dice that have the corresponding number. 1, 1, 2, 4, 4 scored as "fours" gives 8 points.

* **Pair**: Score the sum of the two highest matching dice. 3, 3, 3, 4, 4 scored as "pair" gives 8.

* **Two pairs**: If there are two pairs of dice with the same number, score the sum of those dice. 1, 1, 2, 3, 3 scored as "two pairs" gives 8.

* **Three of a kind**: If there are three dice with the same number, score the sum of these dice. 3, 3, 3, 4, 5 scored as "three of a kind" gives 9.

* **Four of a kind**: If there are four dice with the same number, score the sum of these dice. 2, 2, 2, 2, 5 scored as "four of a kind" gives 8.

* **Small straight**: If the dice read 1, 2, 3, 4, 5, score 15 (the sum of all dice).

* **Large straight**: If the dice read 2, 3, 4, 5, 6, score 20 (the sum of all dice).

* **Full house**: If there is both a pair and three of a kind, score the sum of all dice. 1, 1, 2, 2, 2 scored as "full house" gives 8. Note that, for instance, 4, 4, 4, 4, 4 cannot be scored as "full house".

* **Yahtzee**: If all dice have the same number, score 50 points.

* **Chance**: Score the sum of all dice, regardless of the roll.

## Bonus Challenge

Create another `YahtzeeRoll` method that accepts no parameters and returns the category that should be used to get the maximum possible score for the roll. Assume **Chance** cannot be used, since otherwise it would always be the best choice short of a Yahtzee.
