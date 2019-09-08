type HashTable = (Int, [[Int]])

l = (2, [[1,1],[2,3],[4],[5]])
empty = (initHashTable 2)

initHashTable:: Int->HashTable
initHashTable x = (x, [ []| _ <-[1..2^x]]) 

dimension:: HashTable -> Int
dimension (x, _) = x

keys:: HashTable -> [Int]  --Assume we have to return in list
keys (x, []) = []
keys (x, y:ys) = y++ (keys (x, ys))

keyCount:: HashTable -> Int
keyCount (x, y) = length (keys (x,y))

hash:: Int -> HashTable -> Int
hash key (x, y) = ((2*key) `mod` (2^32)) `div` 2^(32-(dimension (x,y)))

find:: Int -> HashTable -> Maybe Int
find key (x,y) 
	| key `elem` y!!(hash key (x,y)) = Just key
	| otherwise = Nothing

addItem:: Int -> [Int] -> [Int]
addItem x [] = [x]
addItem x y = x:y

add:: Int->HashTable->HashTable
add key h@(x,y)
	| (find key (x,y))==(Just key) = (x,y)
	| otherwise = (x, firsty ++ [key:(y!!hashKey)]++lasty)
	where
		hashKey = hash key h
		firsty = fst (splitAt hashKey y)
		lasty = tail (snd (splitAt hashKey y))
removeItem:: Int -> [Int] -> [Int]
removeItem _ [] = []
removeItem x (y:ys)
	|x==y = []++ys
	|otherwise = y:(removeItem x ys)

sub:: Int->HashTable->HashTable
sub key h@(x,y)
	| (find key h) == Nothing = h
	|otherwise = (x, firsty++[(removeItem key listwx)]++secondy)
	where
	hashKey = hash key h
	firsty = fst (splitAt hashKey y)
	listwx = y!!hashKey
	secondy = tail (snd (splitAt hashKey y))

rehashKeys::[Int]->HashTable -> HashTable
rehashKeys [] h@(x,y) = h
rehashKeys (x:xs) h@(y,ys) = (rehashKeys xs (add x h))

rehash:: HashTable -> HashTable ->HashTable
rehash h@(x,y) h1@(x1,y1)
	= rehashKeys (keys h) h1

insert:: Int -> HashTable -> HashTable
insert x h@(y,ys)
	| numAdded > 2^dimAdded = rehash added (initHashTable (dimAdded+1))
	| otherwise = added
	where
		added = add x h
		numAdded = keyCount added
		dimAdded = dimension added

remove::Int ->HashTable ->HashTable
remove x h@(y,ys)
	|numRemoved < 2^dimRemoved = rehash removed (initHashTable (dimRemoved-1))
	|otherwise = removed

	where
		removed = sub x h
		numRemoved = keyCount removed
		dimRemoved = dimension removed