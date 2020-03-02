Class {
	#name : #CoGlobalVariablesHeuristic,
	#superclass : #CoASTNodeFetcherHeuristic,
	#category : #'Complishon-Heuristics'
}

{ #category : #requests }
CoGlobalVariablesHeuristic >> appliesForNode: aNode inContext: aContext [

	^ aNode isVariable and: [ aNode name first isUppercase ]
]

{ #category : #requests }
CoGlobalVariablesHeuristic >> buildFetcherFor: aNode inContext: complishonContext [

	^ (GlobalVariableComplishonFetcher new
			complishonEnvironment: complishonContext complishonEnvironment;
			yourself), (self next fetcherFor: aNode inContext: complishonContext)
]
