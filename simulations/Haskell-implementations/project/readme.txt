Please load genomeassembly.hs


This project solves the "shortest superstring problem" for genome assembly assuming no repeats.
No repeats means that adjacency matrices produced would have only 1 or zero values, if there is only one sequence. The value may be greater than 1 if a sub-sequence appears more than once in the sequence.


These weights should affect the graph, but we fall back into the same "how many repeats problem". This has to be researched more to find the "Shortest Eulerian Path FULFILLING ALL REPEATS", an algorithm which we would have to develop ourselves.

Justification of the Data Structure:
We have used an Adjacency Matrix because in the real-world problem, the matrix is very dense. Further, for the complete test of Eulerian Paths and Cycles, we need to check for the existence of sub-cycles and for Adjacency Matrices, checking the in-degree and out-degree of each node is O(n) for Adjacency Matrix vs. O(n^2) for Adjacency Lists. Adjacency Matrices are important for future use; 
		 -Weighted edges,
		 -In-degree and out-degree of nodes,
		 -Calculating sub-eulerian cycles.
If needed, the Interface is portable and we can implement Adjacency List in less than 1 hour.

The algorithm for finding Eulerian path requires A list of edges, but that can be done directly from the matrix as well. However, since we are working in teams, we have integrated them into the less efficient, graph algorithm. That is where the inefficiency lies, not at Adjacency Matrix.
----x----x----x----x----x----x----x----x----x----x----x----x----
To test run the following command:
breakAndSequence [YourString] k
e.g. breakAndSequence ["my name is anas masood"] 5

This would first break the input list of strings into kMers of 5. Then it would build a matrix of these kmers and convert this into a form of graph which is needed by the function euler. Then we run the euler function and see that we get the resulting string.
The resulting string comes closer to the original string if the number of kmers increases.

----x----x----x----x----x----x---
If break-down required:

string = yourString
matrixk = createAdjMatrixfromList [string] k
graphk = convertMatrixtoGraph matrixk
nodeList = getMatrixNodeList [string] k
nodeIndices = [0..((length nodeList)-1)]
affanEuler = euler nodeIndices graphk
getStringfromGraph affanEuler nodeList



-x----x----x----x----x----x----
Specific Modules:

composition::[Char] -> Int -> [[Char]]
Breaks an input string into kmers n. Gives duplicates as well.

getNodes:: [[Char]] -> Int -> [[Char]]
Works the same as composition except takes a list of strings.

getMatrixNodeList::[[Char]]->Int->[[Char]]
Returns a sorted list of all nodes in the matrix/graph

createAdjMatrixText:: [Char] -> Int-> AdjMatrix
Creates Matrix of kMers. Creates Nodes and Dictionary automatically.

createAdjMatrixfromList:: [[Char]] -> Int-> AdjMatrix
Creates Matrix from a list of input strings (expected list in the real problem)

convertMatrixtoGraph:: AdjMatrix -> Graph
Converts Matrix to Graph where Graph = [(Int,Int)]

euler::[Node] -> Graph ->  Graph
euler runs the function on a list of nodes to see which node returns the eulerian cycle/path

getStringfromGraph:: Graph -> [[Char]] -> [Char]
Converts Graph (output from Euler) to String based on Node List


