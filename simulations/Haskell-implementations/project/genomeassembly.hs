import qualified Data.List as List
import qualified Data.Map as Map

type Node      = Int
type Edge      = (Int, Int)
type Graph     = [Edge]
type AdjMatrix = [[Int]]

--Helper Function for converting Maybe Int types to Int
maybetoInt::Maybe Int -> Int
maybetoInt Nothing = 0
maybetoInt (Just n) = n

--Helper Function for converting Maybe String types to Int
maybetoStr::Maybe [Char] -> [Char]
maybetoStr Nothing = error "Something messed up - index not found"
maybetoStr (Just string) = string

--Breaks an input string into kmers n. Gives duplicates as well.
composition::[Char] -> Int -> [[Char]]
composition [] _ = []
composition x 0 = [x]
composition x n 
	| (length x) == n = [x]
	| (length x) < n = [x]
	| otherwise = [(take n x)]++(composition (tail x) n)


--Breaks an input list of string into kmers.
getNodes:: [[Char]] -> Int -> [[Char]]
getNodes [] _ = []
getNodes (x:xs) n = (composition x n) ++ (getNodes xs n)


--Returns a list of sorted nodes (k-1mers) from an input list of kMers
getUniqueNodes::[[Char]]->[[Char]]
getUniqueNodes x = List.sort (List.nub (getUniqueNodesHelp x))

--Helper function for recursion
getUniqueNodesHelp::[[Char]] -> [[Char]]
getUniqueNodesHelp [] = []
getUniqueNodesHelp (x:xs) = [(getPrefix x), (getSuffix x)]++(getUniqueNodes xs)



--Returns a sorted list of all nodes in the matrix/graph
getMatrixNodeList::[[Char]]->Int->[[Char]]
getMatrixNodeList x n= List.sort (List.nub (getNodes x (n-1)))

-------- ** Enumerate can work for any index ** ----------
--enumerates input string starting from n for x kmers (n-1 times)
--Returns sorted enumerates with no repeats.
--enumerate:: [Char] -> Int -> Int -> [([Char],Int)]
--enumerate x n kmer = enumerateHelp (List.sort (List.nub (composition x (kmer-1)))) n

--enumerates input string starting from 0 for x kmers (n-1 times)
--Returns sorted enumerates with no repeats.
enumerate:: [Char] -> Int -> [([Char],Int)]
enumerate x kmer = enumerateHelp (List.sort (List.nub (composition x (kmer-1)))) 0

--enumerates ALL Unique Nodes of input [Kmers] starting from 0 where node is k-1mer
--Returns sorted enumerates with no repeats.
enumerateKmer::[[Char]] -> Int -> [([Char],Int)]
enumerateKmer x kmer = enumerateHelp (List.sort (List.nub (getNodes x (kmer-1)))) 0

enumerateIndex:: [Char]->Int -> [(Int,[Char])]
enumerateIndex x kmer = enumerateIndexHelp (List.sort (List.nub (composition x (kmer-1)))) 0

enumerateIndexKmer::[[Char]] -> Int -> [(Int,[Char])]
enumerateIndexKmer x kmer = enumerateIndexHelp (List.sort (List.nub (getNodes x (kmer-1)))) 0

enumerateIndexHelp::[[Char]]->Int -> [(Int,[Char])]
enumerateIndexHelp [] _ = []
enumerateIndexHelp (x:xs) n
	| xs==[] = [(n,x)]
	|otherwise = [(n,x)]++ (enumerateIndexHelp xs (n+1))

enumerateHelp:: [[Char]]->Int->[([Char],Int)]
enumerateHelp [] _= []
enumerateHelp (x:xs) n
	| xs == [] = [(x,n)]
	| otherwise = [(x,n)]++(enumerateHelp xs (n+1))


--Creates a map from an input list of Tuples (Node, Index)
createMapNodestoIndex::[([Char],Int)] -> Map.Map [Char] Int
createMapNodestoIndex x = Map.fromList x 

--Creates a map from an input list of Tuples (Index, Node)
--Function needed for reverse lookup
createMapIndextoNodes::[(Int,[Char])] -> Map.Map Int [Char]
createMapIndextoNodes x = Map.fromList x

--Returns the k-1mer prefix from input kmer
getPrefix:: [Char]-> [Char]
getPrefix [] = []
getPrefix x = init x

--Returns the k-1mer suffix from input kmer
getSuffix:: [Char] -> [Char]
getSuffix [] = []
getSuffix x = tail x


--initializes adjMatrix for [Kmers] with each node initialized to 0.
initializeMatrix::[[Char]]->AdjMatrix
initializeMatrix [] = []
initializeMatrix x = initializeMatrixHelp y (length y)
			where
				y = getUniqueNodes x
--Function for recursive calls of initalising matrix
initializeMatrixHelp::[[Char]]->Int->AdjMatrix
initializeMatrixHelp [] _= []
initializeMatrixHelp (x:xs) n = [take n (repeat 0)]++(initializeMatrixHelp xs n)


--creates Matrix of kMers. Creates Nodes and Dictionary automatically.
createAdjMatrixText:: [Char] -> Int-> AdjMatrix
createAdjMatrixText [] _ = []
createAdjMatrixText myStr n = createMatrixHelp (initializeMatrix (kMers)) kMers dictionary
	where 
		kMers = (composition myStr n)
		dictionary = createMapNodestoIndex (enumerate myStr n)


--Creates Matrix from a list of input strings (expected list in the real problem)
createAdjMatrixfromList:: [[Char]] -> Int-> AdjMatrix
createAdjMatrixfromList [] _ = []
createAdjMatrixfromList list n = createMatrixHelp (initializeMatrix (kMers)) kMers dictionary
	where 
		kMers = (getNodes list n)
		dictionary = createMapNodestoIndex (enumerateKmer list n)

--Input matrix and kmers. Outputs an adjacency matrix of kMers.
createMatrixHelp:: AdjMatrix->[[Char]]->Map.Map [Char] Int -> AdjMatrix
createMatrixHelp myMatrix [] dictionary = myMatrix
createMatrixHelp myMatrix (k:kMers) dictionary=
	createMatrixHelp (firstM ++ [firstI++[i+1]++lastI] ++ lastM) kMers dictionary
	where
		source = init k
		sink = tail k
		sourceInd = maybetoInt (Map.lookup source dictionary)
		sinkInd = maybetoInt (Map.lookup sink dictionary)
		firstM = fst (splitAt sourceInd myMatrix)
		lastM = tail (snd (splitAt sourceInd myMatrix))
		m = myMatrix!!sourceInd
		firstI = fst (splitAt sinkInd (myMatrix!!sourceInd))
		lastI = tail (snd (splitAt sinkInd (myMatrix!!sourceInd)))
		i = m!!sinkInd


{-
createAdjList::[Char] -> Int n -> adjList
createAdjList [] _ = []
createAdjList x 0 = [(x,[])]
createAdjList x n = createAdjListHelp [] (composition x n) (createMap (enumerate x 0 n))

createAdjListHelp::adjList -> [[Char]] -> Map.Map [Char] Int -> adjList
createAdjListHelp myList [] nodeMap = myList
createAdjListHelp myList (kmer:kmers) nodeMap
	= [(kmer,)
-}


--Affan's Implementation
{-
--Converts input matrix and list sorted nodes to a graph
-- /=0 because we are not dealing with repeats right now.
convert' mtx ns = zip ns . map (map fst . filter ((/= 0) . snd) . zip ns) $ mtx

--Merges input List into a tuple
merge [] = [] -- give out the empty list 
merge (x:xs) = (merge' (fst x) (snd x)) ++ (merge xs)

merge' x ys = [ (x, y) | y <- ys ]

graph' [] = [] -- empty graph 
graph' (x:xs) = [(kmerEdge' x)] ++ graph' xs  

kmerEdge' tuple = (x, (a, b))  
		 where 
		 	a = fst(tuple)
		 	b = snd(tuple) 
		 	x = init(a)++b


--Merges a given 0,1 matrix with the list of nodes to create a graph
mergeMatrix [] _ = []
mergeMatrix mtx ns = graph' (merge ((convert' mtx ns)))  
-}

--Affan's more elegant implementation
--Converts Matrix to Graph
convertMatrixtoGraph:: AdjMatrix -> Graph
convertMatrixtoGraph matrix = convertEdgeList (convertMatrixtoEdgeList matrix)

--Converts Matrix to EdgeList
convertMatrixtoEdgeList:: AdjMatrix -> [(Int, [Int])]
convertMatrixtoEdgeList matrix = zip [0..(length matrix)] . map (map fst . filter ((==1).snd).zip [0..(length matrix)]) $ matrix

--converts EdgeList to Graph
convertEdgeList:: [(Int,[Int])] -> Graph
convertEdgeList [] = []
convertEdgeList (x:xs) = (getEdges x) ++ (convertEdgeList xs)

--Helper Function for convertEdgeList
getEdges:: (Int, [Int]) -> Graph
getEdges (_,[]) = []
getEdges (x,(y:ys)) = [(x,y)] ++ getEdges (x,ys)

--Sample Graph and Nodes
{-
graph::Graph
graph = [(1,2),  --edges a ['',()]
         (2,3), 
         (2,4),
         (4,1),
         (3,4),
         (4,6),
         (6,5),
         (5,7),
         (6,7),
         (7,2),
         (7,6)
         ]
 
nodes :: [Node]
nodes = [1..7]
-}

{-euler runs the function on a list of nodes to see which node returns the eulerian cycle/path-}
euler::[Node] -> Graph ->  Graph
euler  [] _  = []
euler  (n:ns) (graph)
				|length graph == length (traverse' (n) (graph) []) = (traverse' (n) (graph) ([])) 
				|otherwise = (euler ns graph)

{-returns the traversed path with respect to a particular node. The function assumes that the debruijn will generate an eulerian cycle-}
traverse'::Node -> Graph -> Graph -> Graph 
traverse' _ [] used  = used
traverse' node unused used 
        |null next = trav --dead end; goto adjancent vertex and traverse the previous cycle from there 
        |otherwise = traverse' (ns) (remove (second) (unused)) (used++[second])  
         where next = filter (\(a, _) -> a == node ) unused
               second = next!!0 
               us = snd (used!!0)
               trav = shift' (used)
               --trav = traverse' us (used) []
               ns = snd (second) -- node   



{-shuffles the path as per the node value-}
shift'::Graph -> Graph 
shift' [] = []
shift' (e:[]) = [e]
shift' (e:es) = es++[e]

{-remove removes a particular element from the list. we will use this helper function in traversal-}
remove _ []                 = []
remove x (y:ys) | x == y    = remove x ys
                    | otherwise = y : remove x ys



--eulerAffan::Graph -> Stack -> Circuit (Graph)
eulerAffan graph = eulerHelp graph (fst (graph!!0)) [] []

eulerHelp graph curNode stack@(stackx:rstack) circuit
	| or [elem (curNode,x) graph | x<-[0..((length graph)-1)]] = eulerHelp graph stackx rstack (curNode:circuit)
	| otherwise = eulerHelp graphRemoved neighbor (curNode:stack) circuit
	where
		graphRemoved = removeAffan graph (curNode,neighbor)
		neighbor = findNeighbor graph curNode

removeAffan::Graph -> Edge -> Graph
removeAffan graph (curNode,neighbor) = fst splitGraph ++ tail (snd splitGraph)
	where 
		splitGraph = splitAt (maybetoInt (List.findIndex (==(curNode,neighbor)) graph)) graph
findNeighbor::Graph -> Node -> Node
findNeighbor [] _ = error "neighbor not found"
findNeighbor graph@(x:xs) curNode
	| fst x == curNode = snd x
	|otherwise = findNeighbor xs curNode
--Converts Graph (output from Euler) to String based on Node List
getStringfromGraph:: Graph -> [[Char]] -> [Char]
getStringfromGraph _ [] = error "NodeList is empty"
getStringfromGraph [] nodeList = []
--PathString = Whole first Node + last letter of last node OR first letter from first node + whole last node
---- We have chosen the fastest one. (head is always fast, tail is always fast)
getStringfromGraph (x:xs) nodeList = path ++ (getStringfromGraph2 xs nodeList)
	where
		firstNode = fst x
		secondNode = snd x
		path = [(head (nodeList!!firstNode))] ++ (nodeList!!secondNode)

--After first string, we only need the last item from the second node.
getStringfromGraph2 [] _ = []
getStringfromGraph2 (x:xs) nodeList = path ++ (getStringfromGraph2 xs nodeList)
	where
		firstNode = fst x
		secondNode = snd x
		path = [last (nodeList!!secondNode)]


breakAndSequence:: [[Char]] -> Int -> [Char]
breakAndSequence [] _ = []
breakAndSequence stringList n = getStringfromGraph euleredGraph nodeList
	where
		euleredGraph  = euler nodeEnumerate graph
		nodeEnumerate = [0..((length nodeList)-1)]
		graph 		  = convertMatrixtoGraph matrix
		matrix 		  = createAdjMatrixfromList stringList n
		nodeList 	  = getMatrixNodeList stringList n


string = "my name is Affan"
matrix4 = createAdjMatrixfromList [string] 4
graph4 = convertMatrixtoGraph matrix4
nodeList = getMatrixNodeList [string] 4
nodeIndices = [0..((length nodeList)-1)]
affanEuler = euler nodeIndices graph4
--getStringfromGraph affanEuler nodeList
