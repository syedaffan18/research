import Debug.Trace

data C = R | B deriving (Show, Eq, Ord)
data RB a = E | N C a (RB a) (RB a) deriving (Show, Eq, Ord) 

debug = flip trace --function for debugging 

insert :: Ord a => a -> RB a -> RB a
insert val tree = {- s is the tree that is supposed to be recreated with the value x -}
	N B z a b  --`debug` "black root \n "{- a is right node , b is the left node; the root node is always black -}
	where
	N _ z a b = insertion tree --`debug` "insertion \n" 
	insertion E = N R val E E --`debug` "empty red \n"
	insertion tree@(N B y a b) 
		| val<y = fix y (insertion a) b --`debug` "black smaller \n "
		| val>y = fix y a (insertion b) --`debug` "black greater \n"
		| otherwise = tree --`debug` "otherwise black \n"
	insertion tree@(N R y a b) 
		| val<y = N R y (insertion a) b --`debug` "\n red smaller"
		| val>y = N R y a (insertion b) --`debug` "\n red greater"
		| otherwise = tree --`debug` "\n red otherwise"


fix :: a -> RB a -> RB a -> RB a
--Fixes node after inserting left tree and right tree with node value a.
fix y (N R x E E) (N R z E E)   = N B y (N R x E E) (N R z E E) --`debug` "\n fix 1"
fix z  E (N R y (N R x a b) E)  = N B x (N R z a b) (N R y E E) --`debug` "\n fix 4"
fix z  E (N R y E (N R x a b))  = N B y (N R z E E) (N R x a b) --`debug` "\n fix 5"
fix z  (N R y E (N R x E E)) E  = N B x (N R y E E) (N R x E E) --`debug` "\n fix 9"
fix z (N R y (N R x a b) c) E   = N B y (N R x a b) (N R z c E) --`debug` "\n fix 10"
fix z (N R x a (N R y b c)) E   = N B y (N R x a b) (N R z c E)  --`debug` "\n fix 11" 
fix x E (N R y b (N R z c d))   = N B y (N R x E b) (N R z c d) --`debug` "\n fix 12"
fix x E (N R z (N R y b c) d)   = N B y (N R x E b) (N R z c d) --`debug` "\n fix 13"
fix z (N R y (N R x a b) c) (N R u m n) = N R z (N B y (N R x a b) c) (N B u m n)  --`debug` "\n fix 14"
fix z (N R x a (N R y b c)) (N R u m n) = N R z (N B x a (N R y b c)) (N B u m n) --`debug` "\n fix 15"
fix x (N R u m n) (N R z (N R y b c) d) = N R x (N B u m n)  (N B z (N R y b c) d) --`debug` "\n fix 16"
fix x (N R u m n) (N R z d (N R y b c)) = N R x (N B u m n) (N B z d (N R y b c)) --`debug` "\n fix 18"
fix z (N R y (N R x a b) c) d@(N B u m n) = N B y (N R x a b) (N R z c d) --`debug` "\n fix 19"
fix z (N R x a (N R y b c)) d@(N B u m n) = N B y (N R x a b) (N R z c d) --`debug` "\n fix 20"  
fix x a@(N B u m n)(N R y b (N R z c d)) = N B y (N R x a b) (N R z c d) --`debug` "\n fix 21"
fix x a@(N B u m n) (N R z (N R y b c) d) = N B y (N R x a b) (N R z c d) --`debug` "\n fix 22"
fix x a b = N B x a b --`debug` "fix 23 \n"


