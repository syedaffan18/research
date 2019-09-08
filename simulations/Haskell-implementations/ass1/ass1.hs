--This submission assumes !! operator does not violate any rules in the assignment.
	--The Extra Tabs are for aesthetics, but ghci gives us a warning.
		--We hope you would forgive us.

-- ****	returns the reverse of an input list
myReverse:: [a] -> [a]
myReverse [x] = [x]
myReverse lst = [last lst] ++ (myReverse (init lst))

-- **** Returns the maximum element of the list
max':: (Ord a) => [a]->a 
max' [x] = x
max' (x:xs)
	| x > max' xs = x
	| otherwise   = max' xs

-- **** returns the kth element of a list.
kthElement:: [a] -> Int -> a
kthElement lst k = lst !! k

-- **** returns the only the unique elements of the list, in a list.
unique:: (Eq a) => [a] -> [a]
unique [] = []
unique [x] = [x]
unique lst
	| (head lst) `elem` (tail lst) = (unique (tail lst))
	| otherwise 				   =[head lst] ++ (unique (tail lst))

-- **** Helper Function for uniqueFrequency.
countFrequency:: (Eq a) => [a] -> a -> Int
countFrequency lst k
	| not (k `elem` lst) 	= 0
	| (head lst) == k   	= 1+countFrequency (tail lst) k
	| otherwise 			= 0 + countFrequency (tail lst) k

-- **** Returns the uniqueList with Frequency of each member.
uniqueList:: (Eq a) => [a] -> [(a,Int)]
uniqueList lst = [ ( (unique lst)!!i , (countFrequency lst (unique lst!!i)) ) | i<-[0..(length (unique lst))-1]]

