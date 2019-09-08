data C = R | B deriving (Show,Eq, Ord)

data RB a = E | N C a (RB a) (RB a) deriving (Show, Eq, Ord)

t=N B 1 E E
--Assume no duplicates.

{- We ended up taking the modular strategy in the end because the way
we wanted to do it earlier (see commented code in the end) would have called
for a great many cases and gave us trouble in recursion at red-uncle as well
as left left and right right cases.
This called for new rotate which returned a new changed tree, and changeColor
which would give a newtree with changed color.
-}

{-
isRoot:: (Eq a)=>RB a-> a -> Bool
isRoot E _= False --Error
isRoot t@(N col n left right) val
	| n == val = True
	|otherwise = False

getParentColor:: RB a -> a -> C
Parent cannot be empty.
getParentColor t@(RB col n left@(coll nl ll rl) right@(colr nr rl rr)) val
  | left==E && right==E = B
  | (n == nl || n==nr) = col
  | n < val = getParentColor left n
  | n > val = getParentColor right n
-}
getValue::(Num a)=> RB a -> a
--returns value of given tree
getValue E = -1 --Error
getValue (N col n _ _) = n


getColor:: RB a -> C
--returns color of given tree
getColor E =  B --Empty trees are considered black
getColor (N col n _ _) = col


rightRotateT::(Ord a)=>RB a-> a -> RB a
--Returns a right-rotated tree at given value val.
----Uses rightRotate (Copied from my treap implementation)
rightRotateT t@(N col n l r) val
	|val==n = rightRotate t
	|val<n  = (N col n (rightRotateT l val) r)
	|val>n  = (N col n l (rightRotateT r val))

rightRotate:: RB a-> RB a
rightRotate E = E
rightRotate t@(N col n E right) = t
rightRotate (N col n (N colleft nleft tleftleft tleftright) (tright)) = 
	N colleft nleft tleftleft (N col n tleftright tright)


leftRotateT::(Ord a) =>RB a-> a -> RB a
--Returns a left-rotated tree at given value val.
----Uses leftRotate (Copied from my treap implementation)
leftRotateT t@(N col n l r) val
	|val==n = leftRotate t
	|val<n  = (N col n (leftRotateT l val) r)
	|val>n  = (N col n l (leftRotateT r val))

leftRotate:: RB a-> RB a
leftRotate E = E
leftRotate t@(N col n left E) = t
leftRotate (N col n (tleft) (N colright nright trightleft trightright)) = 
	(N colright nright (N col n tleft trightleft) trightright) 


insert:: (Ord a) =>(Num a)=> RB a -> a -> RB a
--Inserts a node to a tree and calls fix on that node only.
insert t val = fix (insertRecur t val) val

insertRecur::(Ord a) => RB a -> a -> RB a  
--Binary tree implementation of insert. 
insertRecur E n = (N R n E E)
insertRecur t@(N col n left right) val
	| val == n = t
	| val < n = N col n (insertRecur left val) right
	| val > n = N col n left (insertRecur right val)


getParent:: (Ord a)=>(Num a)=> RB a-> a -> RB a
--Returns parent as tree of a given value a.
getParent t@(N col n l r) val
	| val == (getValue l) || val == (getValue r) = t
	| l/= E && val<n = getParent l val
	| r/= E && val>n = getParent r val
	|otherwise = E --root

getGrandParent:: (Ord a)=>(Num a) => RB a -> a -> RB a
--returns grand-parent as tree of a given value a.
----Makes fix neater.
getGrandParent t@(N col n l r) val =  getParent t (getValue (getParent t val))

getUncle:: (Ord a)=> (Num a)=> RB a-> a -> RB a
--returns uncle as tree of a given value a.
getUncle t@(N col n l r) val
	|p==lg = rg
	|p==rg = lg
	|otherwise = E
	where
		p  = getParent t val
		l@(N colg ng lg rg) = getGrandParent t val

	  
changeColor:: (Ord a)=>RB a->a->C -> RB a
--returns new tree with newCol at given node of Value val.
----Needed for changing color in fix
changeColor t@(N col n l r) val newCol
	|val==n = (N newCol n l r)
	|val<n = (N col n (changeColor l val newCol) r)
	|val>n = (N col n l (changeColor r val newCol))


getLeft::RB a -> RB a
--Used in fix to find left and right of g since g could be empty in fix.
getLeft E = E
getLeft (N col n E _) = E
getLeft (N col n l _) = l

getRight::RB a -> RB a
--Used in fix to find left and right of g since g could be empty in fix.
getRight E = E
getRight (N col n _ E) = E
getRight (N col n _ r) = r

fix:: (Ord a) => (Eq a) =>(Num a)=> RB a-> a -> RB a
fix t@(N col n l r) val
	--If root, getParent will be E
	|p==E = (N B n l r)
	--if parentcolor is black, return tree.
	| (getColor p)==B = t
	--uncle is red case
		--Required we change color of tree before fixing.
		--Sequence: fix(changeColor(changeColor(changeColor(t p b) u b) g r)
	|getColor u == R = fix (changeColor (changeColor (changeColor t (getValue p) B) (getValue u) B) (getValue g) R) (getValue g)
	--Uncle is Black cases
	--Left-Right case
	|getValue p == getValue (getLeft g) && val == getValue (getRight p) = 
			fix (leftRotateT t (getValue p)) (getValue p)
	--Left-Left Case
	|getValue p == getValue (getLeft g) && val == getValue (getLeft p)  = 
			rightRotateT (changeColor (changeColor t (getValue p) B) (getValue g) R) (getValue g)
	--Right-Left case (symmetric to left-right)
	|getValue p == getValue (getRight g) && val == getValue (getLeft p) =
			fix (rightRotateT t (getValue p)) (getValue p)
	--Right-right case (symmetric to left left)
	|getValue p == getValue (getRight g) && val == getValue (getRight p) =
			 leftRotateT (changeColor (changeColor t (getValue p) B) (getValue g) R) (getValue g)
	where --Cannot use t@(N colt nt lt rt) because they could be empty.
		g = getGrandParent t val
		p = getParent t val 
		u = getUncle t val
{-

hasRedUncle:: (Ord a) => RB a -> a -> Bool
hasRedUncle (N col n E E) _ = False  --zero level
hasRedUncle (N col n l@(N coll nl E E) r@(N colr nr E E)) _ = False --one level

hasRedUncle (N col n l@(N coll nl 	--Two Levels, one empty
						ll@(N colll nll _ _)
						lr@(N collr nlr _ _)
						)
					 E
			) val
	|(val==nll || val==nlr) = False
	|otherwise = hasRedUncle l val

hasRedUncle (N col n E   --Symmetrical
					r@(N colr nr 
					 	rl@(N colrl nrl _ _)
					 	rr@(N colrr nrr _ _)
					 	)
			) val
	|(val==nrl || val==nrr) = False
	|otherwise = hasRedUncle r val


hasRedUncle (N col n l@(N coll nl --Complete Tree Don't care about great-grandchildren for now
						ll@(N colll nll _ _)
						lr@(N collr nlr _ _)
						)
					 r@(N colr nr 
					 	rl@(N colrl nrl _ _)
					 	rr@(N colrr nrr _ _)
					 	)
			) val
	|(val==nll || val==nlr) && (colr==R) = True
	|(val==nrl || val==nrr) && (coll==R) = True
	|val<n = hasRedUncle l val
	|val>n = hasRedUncle r val


fix::(Eq a)=> (Ord a)=>RB a-> a ->RB a
--Fix on Empty Tree yields Empty Tree (For Recursion)
fix E _ = E
--If tree is root, val MUST be of root. Return Black root.
fix t@(N colg ng E E) _ = N B ng E E
--If tree has two children only, we return black root, red children
fix t@(N colg ng lg@(N collp nlp E E) 
				  rg@(N colrp nrp E E)
		) val =
	(N B ng (N R nlp E E) (N R nrp E E))


fix t@(N colg ng lg@(N collp nlp E E) 
				  rg@(N colrp nrp E E)
		) val
	| val  ==ng = (N B ng lg rg)  --Fix(root) returns black
	| (val ==nlp || val== nrp) && colg ==B = t --If parent is black
	--No uncles therefore no uncle cases.
	|otherwise = t   --This would actually be an error

fix t@(N colg ng lg@(N collp nlp llp@(N colll nll lll llr) 
								lrp@(N collr nlr lrl lrr)
					) 
				  rg@(N colrp nrp rlp@(N colrl nrl rll rlr) 
				  				rrp@(N colrr nrr rrl rrr)
				  	)
		) val
	| val == ng = (N B ng lg rg) --If fix(root) then return black.
	| (val == nlp || val == nrp) && (colg  == B ) = t --If parent is black1
	| (val == nll || val == nrl) && (collp == B) = t --If parent is black-LeftChild
	| (val == nrl || val == nrr) && (colrp == B) = t --If parent is black-RightChild
	--Uncle is Red cases
	| (val == nll || val == nlr) && (colrp == R) = fix (N R ng 
														(N B nlp llp lrp)
														(N B nrp rlp rrp)
														) ng   --Calling fix on GP and changing colors.
	--Ditto
	| (val == nrl || val == nrr) && (collp == R) = fix (N R ng 
														(N B nlp llp lrp)
														(N B nrp rlp rrp)
														) ng   --Calling fix on GP and changing colors.
	--Uncle is black cases. Empty should also be considered black.
	| (val == nlr && collr==R && collp==R) && (colrp ==B || rg==E) = fix (N colg ng (leftRotate lg) rg) nlp  --If left-Right, then rotateLeft(parent) and fix val parent.
	| (val == nll && colll==R && collp==R) && (colrp ==B || rg==E) = rightRotate (N R ng (N B nlp llp lrp) --parent to be black
											rg --no change on uncle
											) --If left-left, then change gp to red, p to b and rotateright
	| (val == nrl && colrl==R && colrp==R) && (collp ==B || rg==E) = fix (N colg ng lg (rightRotate rg)) nrp  --If right-left, then rotate right parent and fix val parent.
	| val == nrr  && colrr==R && colrp==R) && (collp ==B || rg==E)= leftRotate (N R ng lg --no change on uncle
																					   (N B nrp rlp rrp) --color parent black
																				)  --If left-left, then change gp to red, p to b and rotateleft
	|val<ng = (N colg ng (fix lg val) rg)  --Recursive call on left child 
	|val>ng = (N colg ng lg (fix rg val))

****Affan's Approach ****
import Debug.Trace

data C = R | B deriving (Show, Eq, Ord)
data RB a = E | N C a (RB a) (RB a) deriving (Show, Eq, Ord) 

debug = flip trace --function for debugging 

insert :: Ord a => a -> RB a -> RB a
insert val tree = {- s is the tree that is supposed to be recreated with the value x -}
	N B z a b `debug` "black root \n "{- a is right node , b is the left node; the root node is always black -}
	where
	N _ z a b = insertion tree `debug` "insertion \n" 
	insertion E = N R val E E `debug` "empty red \n"
	insertion tree@(N B y a b) 
		| val<y = fix y (insertion a) b `debug` "black smaller \n "
		| val>y = fix y a (insertion b) `debug` "black greater \n"
		| otherwise = tree `debug` "otherwise black \n"
	insertion tree@(N R y a b) 
		| val<y = N R y (insertion a) b `debug` "\n red smaller"
		| val>y = N R y a (insertion b) `debug` "\n red greater"
		| otherwise = tree `debug` "\n red otherwise"


fix :: a -> RB a -> RB a -> RB a
fix y (N R x E E) (N R z E E)   = N B y (N R x E E) (N R z E E) `debug` "\n fix 1"
fix z  E (N R y (N R x a b) E)  = N B x (N R z a b) (N R y E E) `debug` "\n fix 4"
fix z  E (N R y E (N R x a b))  = N B y (N R z E E) (N R x a b) `debug` "\n fix 5"
fix z  (N R y E (N R x E E)) E  = N B x (N R y E E) (N R x E E) `debug` "\n fix 9"
fix z (N R y (N R x a b) c) E   = N B y (N R x a b) (N R z c E) `debug` "\n fix 10"
fix z (N R x a (N R y b c)) E   = N B y (N R x a b) (N R z c E)  `debug` "\n fix 11" 
fix x E (N R y b (N R z c d))   = N B y (N R x E b) (N R z c d) `debug` "\n fix 12"
fix x E (N R z (N R y b c) d)   = N B y (N R x E b) (N R z c d) `debug` "\n fix 13"
fix z (N R y (N R x a b) c) (N R u m n) = N R z (N B y (N R x a b) c) (N B u m n)  `debug` "\n fix 14"
fix z (N R x a (N R y b c)) (N R u m n) = N R z (N B x a (N R y b c)) (N B u m n) `debug` "\n fix 15"
fix x (N R u m n) (N R z (N R y b c) d) = N R x (N B u m n)  (N B z (N R y b c) d) `debug` "\n fix 16"
fix x (N R u m n) (N R z d (N R y b c)) = N R x (N B u m n) (N B z d (N R y b c)) `debug` "\n fix 18"
fix z (N R y (N R x a b) c) d@(N B u m n) = N B y (N R x a b) (N R z c d) `debug` "\n fix 19"
fix z (N R x a (N R y b c)) d@(N B u m n) = N B y (N R x a b) (N R z c d) `debug` "\n fix 20"  
fix x a@(N B u m n)(N R y b (N R z c d)) = N B y (N R x a b) (N R z c d) `debug` "\n fix 21"
fix x a@(N B u m n) (N R z (N R y b c) d) = N B y (N R x a b) (N R z c d) `debug` "\n fix 22"
fix x a b = N B x a b `debug` "fix 23 \n"


-}

