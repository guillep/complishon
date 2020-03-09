"
I implement an heuristic for messages sent to variables whose value is available in the context, for example in a debugger, workspace or inspector.
If there is a value for the variable, create a fetcher for messages of its class.

See my superclass for details.
"
Class {
	#name : #CoVariableValueMessageHeuristic,
	#superclass : #CoVariableMessageHeuristic,
	#category : #'Complishon-Heuristics'
}

{ #category : #requests }
CoVariableValueMessageHeuristic >> buildFetcherFor: aRBMessageNode inContext: aContext [

	"Try to fetch the real value of the variable from the context"
	self
		valueOfVariable: aRBMessageNode receiver name
		inContext: aContext
		ifPresent: [ :value | ^ self newMessageInHierarchyFetcherForClass: value class ].
	
	"If we found none, continue"
	^ self next fetcherFor: aRBMessageNode inContext: aContext
]

{ #category : #requests }
CoVariableValueMessageHeuristic >> valueOfVariable: aName inContext: complishonContext ifPresent: aBlock [

	| binding |
	"In the debugger, the binding values comes in the doItContext.
	If we find in the doItContext has a variable with the given name, use it, otherwise ignore it."
	(complishonContext doItContext ifNotNil: [ :c | 
		(c astScope lookupVar: aName)
			ifNotNil: [ c lookupSymbol: aName ] ])
		ifNotNil: [ :value | ^ aBlock value: value ].

	"In the playground, the binding values comes in the bindings of the requestor.
	If we find in the requestor a binding with the given name, use it, otherwise ignore it."
	binding := (complishonContext doItRequestor bindingOf: aName)
		ifNil: [ ^ self ].
	
	^ aBlock value: binding value
]
