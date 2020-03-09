"
I implement an heuristic for local variables accessible from the current AST node.

See my superclass for details.
"
Class {
	#name : #CoLocalScopeVariablesHeuristic,
	#superclass : #CoASTNodeFetcherHeuristic,
	#category : #'Complishon-Heuristics'
}

{ #category : #requests }
CoLocalScopeVariablesHeuristic >> appliesForNode: aNode inContext: aContext [

	^ true
]

{ #category : #requests }
CoLocalScopeVariablesHeuristic >> buildFetcherFor: aNode inContext: aContext [

	^ ((CoMethodVariableFetcher new) complishonASTNode: aNode),
			(self next fetcherFor: aNode inContext: aContext)
]
