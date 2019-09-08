speed distance time = distance/time

salePrice sellingPrice discountRate = sellingPrice - (discountRate/100) *sellingPrice

largestNumber num1 num2 num3 = max (max num1 num2) num3

average numberList = (fromIntegral (sum numberList)) /  (fromIntegral (length numberList))

positiveOdd num = [1,3..num]

positiveSum num = sum(positiveOdd num)

divisible num = [x | x <- [1 .. ] , x `mod` num == 0]

divisibleByNum num = product [x | x <- [1..num], even x]

getFromTuple tuple = snd (fst tuple) 