type BinaryHeap a = (Int, [Maybe a])

th = (6, [Just 7,Just 11,Just 25,Just 14,Just 23,Just 10,Nothing])::BinaryHeap Int
--a Slice a list. Limits are inclusive
slice::[a]->Int->Int->[a]
slice x start end = take (end-start+1) (drop start x)

--b Swap elements at given indices in the list
swap::Int->Int->[a]->[a]
swap a b x
 | b < a = swap b a x
 | otherwise = take (a-1) x ++ [x!!b] ++ (slice x (a+1) (b-1)) ++[x!!a]++(drop (b+1) x)

--c empty heap of the provided type
initHeap::a->BinaryHeap a
initHeap x = (0,[Nothing])

--d the size of the heap
sizeHeap::BinaryHeap a->Int
sizeHeap b@(a,x) = length x

--e) Returns the elements
elementsHeap::BinaryHeap a->[Maybe a]
elementsHeap b@(a,x) =  x

--f)
parentIdx::Int->Int
parentIdx 0 = error "Root has no parent"
parentIdx x = (x-1)`div`2

--g) Left Child idx
leftChildIdx:: Int -> Int
leftChildIdx x = 2*x+1

--h) Right Child idx
rightChildIdx:: Int -> Int
rightChildIdx x = 2*x+2

--i Resize up
resizeUpHeap::BinaryHeap a -> BinaryHeap a 
resizeUpHeap b@(x,y)
				   | x == (length y) = (x, (slice y 0 ((length y) -1)) ++ 
				   		(take ((length y)+1) (cycle [Nothing])))
				   | otherwise = b

--j bubbleUp
bubbleUpHeap :: (Ord a) => Int -> BinaryHeap a -> BinaryHeap a
bubbleUpHeap 0 b = b
bubbleUpHeap x b@(num, heap)
	|(heap!!x) < (heap!!(parentIndex)) = bubbleUpHeap parentIndex (num, swappedHeap)
	| otherwise = b
	where
		parentIndex = parentIdx x
		swappedHeap = (swap x parentIndex heap)

--k
insert:: Maybe a->Int->[Maybe a]->[Maybe a]
insert  x index list = (take (index) list) ++ [x] ++(drop (index+1) list)


addHeap:: (Ord a)=>Maybe a->BinaryHeap a -> BinaryHeap a
addHeap x b@(num,heap)
	| num == (length heap) = addHeap x (resizeUpHeap b)
	| otherwise = bubbleUpHeap num (num+1, (insert x num heap))