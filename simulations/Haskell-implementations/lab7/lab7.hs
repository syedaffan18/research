data SkipList = NIL | Node Int [SkipList] deriving (Ord, Show, Eq)

n6 = Npde 6 [NIL NIL]
n5 = Node 5 [n6 n6]
n4 = Node 4 [n5 n5 NIL NIL NIL NIL]
n3 = Node 3 [n4 n4 n4]
n2 = Node 2 [n3 n3 n3 n4]
n1 = Node 1 [n2]
n0 = Node 0 [n1]
ns = Node (-1) [n0 n2 n2 n2 n4 n4]

initList::SkipList
--Returns empty sentinel.
initList = Node 0 [NIL]

node::Int ->Int -> SkipList	
--Returns node with val n and skiplist of h nils.
node n h = Node n (take (h+1) (repeat NIL))

val::SkipList -> Int
--Returns value of input node.
val (Node x _) = x

nodeHeight::SkipList->Int
--Returns height of node. -1 for index.
nodeHeight (Node x []) = 0
nodeHeight (Node x ys) = (length ys) -1

listHeight::SkipList->Int
--returns the maximum height of list.
listHeight NIL = 0
listHeight r@(Node _ next) = max (nodeHeight r) (listHeight (next!!0))

numElements::SkipList -> Int -> Int
--Returns the number of elements at level
numElements NIL _ = -1
numElements (Node x next) level = 1+ numElements (next!!level) level

contains ::SkipList -> Int -> Bool
contains NIL _ = False
contains list@(Node x next) n 
		|x==(val (next!!0)) = True
		|otherwise = contains (next!!0) n

--getCompleteStack::SkipList ->SkipList ->[SkipList]
--Inputs two skipLists and returns the stack::how they will be updated.
--getStack newNode@(Node nodex nodenext) list@(Node x next)

getDescentStack::SkipList -> Int ->Int-> [SkipList]
--Returns the stack until we descend to the required value
getDescentStack _ (-1) _ = []
getDescentStack NIL _ _ = error "Invalid access"
getDescentStack list@(Node x next) level value
	| next!!level /= NIL && (val (next!!level))<value  = getDescentStack (next!!level) level value
	| next!!level /= NIL && (val (next!!level))==value = error "Value already in list"
	| otherwise = list: (getDescentStack list (level-1) value)