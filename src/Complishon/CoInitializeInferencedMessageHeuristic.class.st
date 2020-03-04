Class {
	#name : #CoInitializeInferencedMessageHeuristic,
	#superclass : #CoASTNodeFetcherHeuristic,
	#category : #'Complishon-InitializeInferenceHeuristic'
}

{ #category : #requests }
CoInitializeInferencedMessageHeuristic >> appliesForNode: aNode inContext: aContext [

	^ aContext complishonClass notNil
		and: [ aNode receiver isVariable ]
]

{ #category : #requests }
CoInitializeInferencedMessageHeuristic >> buildFetcherFor: aNode inContext: aContext [

	| variables fetcher |
	variables := self inferTypesIn: aContext complishonClass.
	fetcher := self next fetcherFor: aNode inContext: aContext.
	variables
		at: aNode receiver name
		ifPresent: [ :types |
			types do: [ :each |
				fetcher := (self newMessageInHierarchyFetcherForClass: each), fetcher ] ].
	^ fetcher
]

{ #category : #requests }
CoInitializeInferencedMessageHeuristic >> inferTypesIn: aClass [

	^ CoTypeInferencer new
		inferFrom: aClass;
		variables
]
