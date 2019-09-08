--a)

data BTree = Empty | BTree {numLeft::(Maybe Int)
							 ,numMid ::(Maybe Int)
							 ,numRight::(Maybe Int)
							 ,leftMost::  BTree
							 ,leftMid:: BTree
							 ,rightMid:: BTree
							 ,rightMost:: BTree
							 } deriving (Show, Read, Eq)


bottom1 = BTree{numLeft = Just 0, numMid = Just 10, numRight = Nothing, leftMost = Empty, leftMid = Empty, rightMid = Empty, rightMost = Empty}
bottom2 = BTree{numLeft = Just 30, numMid = Just 35, numRight = Nothing, leftMost = Empty, leftMid = Empty, rightMid = Empty, rightMost = Empty}
bottom3 = BTree{numLeft = Just 45, numMid = Nothing, numRight = Nothing, leftMost = Empty, leftMid = Empty, rightMid = Empty, rightMost = Empty}
bottom4 = BTree{numLeft = Just 60, numMid = Just 70, numRight = Nothing, leftMost = Empty, leftMid = Empty, rightMid = Empty, rightMost = Empty}
bottom5 = BTree{numLeft = Just 90, numMid = Nothing, numRight = Nothing, leftMost = Empty, leftMid = Empty, rightMid = Empty, rightMost = Empty}

bottomup1 = BTree{numLeft = Just 20, numMid = Just 40, numRight = Nothing, leftMost = bottom1, leftMid = bottom2, rightMid = bottom3, rightMost = Empty}
bottomup2 = BTree{numLeft = Just 80, numMid = Nothing, numRight = Nothing, leftMost = bottom4, leftMid = bottom5, rightMid = Empty, rightMost = Empty}

top = BTree{numLeft = Just 50, numMid = Nothing, numRight = Nothing, leftMost = bottomup1, leftMid = bottomup2, rightMid = Empty, rightMost = Empty}


--b)

--Assuming no duplicates.
find:: (Maybe Int) -> BTree -> BTree

find _ Empty = Empty
find x tree@(BTree numLeft numMid numRight leftMost leftMid rightMid rightMost) 
	|x == numLeft = tree
	|x<numLeft = find x (leftMost)
	|x == numMid = tree 
	|x < numMid = find x (leftMid)
	|x == numRight = tree
	|x < numRight = find x (rightMid)
	|otherwise = find x (rightMost)


--Assuming x is not in tree

insert::(Maybe Int) -> BTree -> BTree
insert Nothing tree = tree
insert x Empty = BTree{numLeft = x, numMid = Nothing, numRight = Nothing, leftMost = Empty, leftMid = Empty, rightMid = Empty, rightMost = Empty}
insert x tree@(BTree numLeftin numMidin numRightin leftMostin leftMidin rightMidin rightMostin)
	| (isLeaf tree)==False && x<numLeftin = BTree {numLeft = numLeftin, numMid= numMidin, numRight = numRightin, leftMost = (insert x leftMostin), leftMid =  leftMidin, rightMid = rightMidin, rightMost = rightMostin}
	| (isLeaf)==False && x<numMidin = BTree {numLeft = numLeftin, numMid = numMidin, numRight = numRightin, leftMost = leftMostin, leftMid = insert x leftMidin, rightMid = rightMidin, rightMost = rightMostin}
--	| (isLeaf)==False && x<numRightin = BTree {numLeft = numLeftin, numMid = numMidin, numRight = numRightin, insert x rightMid
--	| (isLeaf)==False && x>numRightin = insert x rightMost
--	| (isLeaf)==False &&  (hasSpace tree==1) = BTree{numLeft = }


hasSpace::BTree -> Int
hasSpace tree@(BTree numLeft numMid numRight leftMost leftMid rightMid rightMost) 
	| numMid /= Nothing = 1
	| numRight /= Nothing = 2
	|otherwise = 0

isLeaf:: BTree -> Bool
isLeaf tree@(BTree numLeft numMid numRight leftMost leftMid rightMid rightMost) 
	| leftMost == Empty && leftMid == Empty && rightMid == Empty && rightMost ==Empty = True
	| otherwise = False

