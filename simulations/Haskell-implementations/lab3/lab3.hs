data Tree a = EmptyTree| Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

  
depth :: (Ord a) => a -> Tree a -> Int

depth x EmptyTree =  -1  
depth x (Node a left right)   
    | x == a = 0
    | depth x left > -1 = 1 +  (depth x left)   
    | depth x right > -1  = 1 + (depth x right) 
    | otherwise = -1


--height :: (Ord a) => a -> Tree a -> a
--height _ EmptyTree = 0 
--height x (Node a left right)
--	| x == a = 1 + max ((height x left) (height x right))



tree = Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) (Node 7 (Node 6 EmptyTree EmptyTree) (Node 8 EmptyTree EmptyTree))  


insert:: (Ord a) => a -> Tree a -> Tree a
insert x EmptyTree = Node x EmptyTree EmptyTree
insert x (Node a left right)
	| x==a = Node x left right
	| x<a  = Node a (insert x left) right
	| x>a  = Node a left (insert x right)

exists::(Ord a)=> a -> Tree a -> Bool
exists x EmptyTree = False
exists x (Node a left right)
	| x==a = True
	| x<a  = exists x left
	| x>a  = exists x right

find::(Ord a)=>a -> Tree a -> Tree a
find _ EmptyTree = EmptyTree
find x t@(Node a left right)
	| x==a = t
	| x<a = find x left
	| x>a = find x right

remove:: (Ord a) => a -> Tree a -> Tree a
remove _ EmptyTree = EmptyTree
remove x t@(Node a left right)
	| not (exists x (Node a left right)) = t
	| left == EmptyTree && right == EmptyTree && x==a = EmptyTree
	| x==a && left /= EmptyTree && right==EmptyTree = left
	| x==a && left == EmptyTree && right /= EmptyTree = right
	| x==a && left /= EmptyTree && right /= EmptyTree = findSuccRight t
	| x<a = remove x right
	| x>a = remove x left 

findSuccRight::(Ord a) => Tree a ->Tree a
findSuccRight (Node a left right) = (Node (findSuccLeft right) left (remove (findSuccLeft right) right))


findSuccLeft::(Ord a) => Tree a -> a
findSuccLeft t@(Node a EmptyTree _) = a
findSuccLeft (Node a left _) = (findSuccLeft left) 