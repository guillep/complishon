"
I implement an heuristic for variables in a workspace/playground.

See my superclass for details.
"
Class {
	#name : #CoWorkspaceVariablesHeuristic,
	#superclass : #CoASTNodeFetcherHeuristic,
	#category : #'Complishon-Heuristics'
}

{ #category : #requests }
CoWorkspaceVariablesHeuristic >> appliesForNode: aNode inContext: aContext [

	^ aContext isWorkspace
]

{ #category : #requests }
CoWorkspaceVariablesHeuristic >> buildFetcherFor: aNode inContext: aContext [

	self haltIf: [ aContext doItRequestor model variableBindings keys isEmpty ].
	^ ((GenericComplishonFetcher onCollection: aContext doItRequestor model variableBindings keys)
		collect: [ :e | NECLocalEntry contents: e node: self ]),
			(next fetcherFor: aNode inContext: aContext)
]
