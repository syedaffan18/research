data RBTree = Empty| RBTree Int Bool (RBTree) (RBTree) (RBTree) deriving (Show, Read, Eq, Ord)
--We will be storing Black as False, and Red as True.
rb = RBTree 11 False Empty left1 right1

left1 = RBTree 2 True rb left2 right12
right12 = RBTree 7 False left1 left22 right122
left22 = RBTree 5 True right12 left222 Empty
left222 = RBTree 4 True left22 Empty Empty
right122 = RBTree 8 True right12 Empty Empty

left2 = RBTree 1 False left1 Empty Empty


right1 = RBTree 14 False rb Empty right22
right22 = RBTree 15 True right1 Empty Empty


getColor:: RBTree -> Bool
getColor Empty = False
getColor (RBTree n col parent left right)= col

getParent:: RBTree -> RBTree
getParent Empty = Empty
getParent (RBTree _ _ parent _ _) = parent

rightRotate:: RBTree -> RBTree 
rightRotate Empty = Empty
rightRotate (RBTree n col parent1 (RBTree n2 col2 parent2 t1a t1b) (t2)) = 
	RBTree n2 col2 parent2 t1a (RBTree n col parent1 t1b t2)

leftRotate:: RBTree -> RBTree 
leftRotate Empty = Empty
leftRotate (RBTree n col parent1 (t1) (RBTree n2 col2 parent2 t2a t2b)) = 
	RBTree n2 col2 parent1 (RBTree n col parent2 t1 t2a) t2b 

insert:: RBTree -> Int -> RBTree
insert Empty n = Fix(RBTree n True Empty Empty Empty)  
insert (RBTree n col parent left right)