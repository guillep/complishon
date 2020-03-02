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

	^ ((MethodVariableComplishonFetcher new) complishonASTNode: aNode),
			(self next fetcherFor: aNode inContext: aContext)
]
