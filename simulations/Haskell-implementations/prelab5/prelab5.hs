data Treap = Empty| Treap Int Int (Treap) (Treap) deriving (Show, Read, Eq, Ord)
bt = Treap 10 2 (Treap 5 3 (Treap 2 4 Empty (Treap 3 5 Empty Empty)) Empty) (Treap 20 1 Empty Empty)

rightRotate:: Treap -> Treap 
rightRotate Empty = Empty
rightRotate (Treap n p (Treap n2 p2 t1a t1b) (t2)) = Treap n2 p2 t1a (Treap n p t1b t2)

leftRotate::Treap -> Treap 
leftRotate Empty = Empty
leftRotate  (Treap n p (t1) (Treap n2 p2 t2a t2b)) = Treap n2 p2 (Treap n p t1 t2a) t2b

heapRestore ::Treap-> Treap
heapRestore Empty = Empty
heapRestore t@(Treap n p t1 t2)
	| t1 /= Empty && (priority t1) < p = heapRestore (rightRotate t)
	| t2 /= Empty && (priority t2) < p = heapRestore (leftRotate t)
	| otherwise = Treap n p (heapRestore t1) (heapRestore t2)

priority :: Treap -> Int
priority Empty = -1
priority (Treap _ p _ _) = p



insert :: Int -> Int-> Treap-> Treap
insert n p Empty = Treap n p Empty Empty
insert n p t = heapRestore (binsert n p t) 

binsert:: Int -> Int -> Treap -> Treap   --Same as binary insert
binsert n p t@(Treap n2 p2 t1 t2)
	| n <= n2 = Treap n2 p2 (binsert n p t1) t2
	|n > n2  = Treap n2 p2 t1 (binsert n p t2)
    | otherwise = t

findSmallest :: Treap-> (Int, Int)
findSmallest t1@(Treap x xp Empty _) = (x, xp)
findSmallest t@(Treap x xp t1 t2) = findSmallest t1

remove1 :: Int -> Treap-> Treap 
remove1 n t@(Treap a ap t1 t2)
	| n < a = Treap a ap (remove1 n t1) t2
	| n > a = Treap a ap t1 (remove1 n t2)
	| n == a && t1 == Empty && t2 == Empty = Empty
	| n == a && t1 == Empty && t2 /= Empty = t2
	| n == a && t1 /= Empty && t2 == Empty = t1
	| n == a && t1 /= Empty && t2 /= Empty = Treap (fst (findSmallest t2)) (snd (findSmallest t2)) t1 (remove1 (fst (findSmallest t2)) t2) 
	| otherwise = t

remove :: Int -> Treap-> Treap
remove _ Empty = Empty
remove n t = heapRestore (remove1 n t)