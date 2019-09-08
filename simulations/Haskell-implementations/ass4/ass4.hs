import Data.Bits

data MeldableHeap a = Node a (MeldableHeap a) (MeldableHeap a) | Nil


bitwiseAnd::(Bits a) => a -> a -> a
bitwiseAnd a b = (.&.) a b

-- **Problem 1
--a)  Num a added for And with 1
mergeHeap::(Ord a, Bits a, Num a) => MeldableHeap a -> MeldableHeap a -> MeldableHeap a
mergeHeap Nil h2 = h2
mergeHeap h1 Nil = h1
mergeHeap h1@(Node x1 (h1l) (h1r)) h2@(Node x2 (h2l) (h2r))
	| x1>x2 = mergeHeap h2 h1
	| (bitwiseAnd 1 x1) == 0 = (Node x1 (mergeHeap h1l h2) h1r)  --very simple random as suggested in Piazza
	| otherwise = (Node x1 h1l (mergeHeap h1r h2))

--b)
addHeap:: (Ord a, Bits a, Num a) => a -> MeldableHeap a -> MeldableHeap a
addHeap a Nil = (Node a Nil Nil)
addHeap a h@(Node x hl hr) = mergeHeap (Node a Nil Nil) h

--c)
removeHeap::(Ord a, Bits a, Num a) => MeldableHeap a -> MeldableHeap a
removeHeap h@(Node x hl hr) = mergeHeap hl hr


-- **Problem 2
getHeap:: (Ord a, Bits a, Num a) => [a] -> MeldableHeap a -> MeldableHeap a
--Helper function for heapSort. Gets a list of [a] and returns a heap for list.
getHeap [] h = h
getHeap (x:xs) h = getHeap xs (addHeap x h)

removeList::(Ord a,Bits a, Num a)=> MeldableHeap a -> [a]
--Helper function for heapSort. Gets a heap and returns a list with items removed in remove order.
removeList Nil = []
removeList h@(Node x hl hr) = [x] ++ (removeList (removeHeap h))

heapSort::(Ord a, Bits a, Num a) => [a] -> [a]
heapSort [] = []
heapSort x = removeList (getHeap x Nil)