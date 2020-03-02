"
I implement an heuristic for messages sent to variables in the form ""aX"" or ""anX"".
If a class X is available in the environment, I return a fetcher for X's instance side messages.

See my superclass for details.
"
Class {
	#name : #CoVariableWithTypeNameMessageHeuristic,
	#superclass : #CoVariableMessageHeuristic,
	#category : #'Complishon-Heuristics'
}

{ #category : #requests }
CoVariableWithTypeNameMessageHeuristic >> buildFetcherFor: aRBMessageNode inContext: complishonContext [

	"Heuristic: variables with type information.
	This is maybe an instance of this class, autocomplete for that class first, then continue with normal completion.
	E.g., aCollection => use completion for Collection class first, then normal collection.
	There are two cases: aPoint and anASTCache"
	aRBMessageNode receiver name size > 1
		and: [ complishonContext
				environmentAt: aRBMessageNode receiver name allButFirst asSymbol
				ifPresent: [ :global | 
					^ (self newFetcherForMaybeGlobalInstance: global)
						, (self next fetcherFor: aRBMessageNode inContext: complishonContext) ] ].
	
	aRBMessageNode receiver name size > 2
		and: [ complishonContext
				environmentAt: (aRBMessageNode receiver name allButFirst: 2) asSymbol
				ifPresent: [ :global | 
					^ (self newFetcherForMaybeGlobalInstance: global)
						, (self next fetcherFor: aRBMessageNode inContext: complishonContext) ] ].
				
	^ self next fetcherFor: aRBMessageNode inContext: complishonContext
]

{ #category : #requests }
CoVariableWithTypeNameMessageHeuristic >> newFetcherForMaybeGlobalInstance: aGlobal [
	"Fetcher for messages to instance variables containing type information.
	For example: aCollection could autocomplete collection messages."

	"This is a class or trait. Autocomplete instance-side messages" 
	aGlobal isClassOrTrait ifTrue: [
		^ ClassImplementedMessagesComplishonFetcher new
			completionClass: aGlobal instanceSide;
			forHierarchy ].

	"This is not a class binding but a global object.
	E.g., aSmalltalk
	Autocomplete based on its class"
	^ ClassImplementedMessagesComplishonFetcher new
		completionClass: aGlobal class;
		forHierarchy
]
