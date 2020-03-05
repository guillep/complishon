Class {
	#name : #CoStatistics,
	#superclass : #Object,
	#instVars : [
		'acceptedEntries',
		'cancelledCompletions'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : #'Complishon-Statistics'
}

{ #category : #singleton }
CoStatistics class >> reset [
	
	UniqueInstance := nil
]

{ #category : #singleton }
CoStatistics class >> uniqueInstance [
	
	^ UniqueInstance ifNil: [ 
		UniqueInstance := self new ]
]

{ #category : #accessing }
CoStatistics >> acceptedEntries [
	
	^ acceptedEntries
]

{ #category : #accessing }
CoStatistics >> averageTypedCharacters [
	
	| count total |
	count := 0.
	total := 0.
	acceptedEntries do: [ :entries |
		count := count + entries size.
		total := total + (entries sum: [ :entry | entry numberOfTypedCharacter ]).
	].
	
	^ count = 0
		ifTrue: [ 0 ]
		ifFalse: [ total / count ]
]

{ #category : #accessing }
CoStatistics >> averageTypedCharactersAt: anIndex [
	
	| count total entries |
	count := total := 0.
	entries := acceptedEntries at: anIndex ifAbsent: [ ^ 0 ].
	count := count + entries size.
	total := entries sum: [ :entry | entry numberOfTypedCharacter ].
	^ count = 0
		ifTrue: [ 0 ]
		ifFalse: [ total / count ]
]

{ #category : #accessing }
CoStatistics >> entriesAtIndex: anInteger [ 
	
	^ acceptedEntries at: anInteger ifAbsentPut: [ CoStatisticsAcceptedEntry new ]
]

{ #category : #accessing }
CoStatistics >> entriesGeneratedBy: aSource [

	^ acceptedEntries sum: [ :entries | 
		entries count: [ :entry | entry source = aSource ] ]
]

{ #category : #querying }
CoStatistics >> groupBy: aBlockClosure [ 
	
	^ acceptedEntries gather: [ :entriesByIndex |
		entriesByIndex select: aBlockClosure ]
]

{ #category : #accessing }
CoStatistics >> initialize [

	super initialize.
	acceptedEntries := Dictionary new.
	cancelledCompletions := Dictionary new
]

{ #category : #events }
CoStatistics >> logAcceptEntry: anEntry [
	
	| entries |
	self haltIf: [anEntry index isNil].
	entries := acceptedEntries at: anEntry index ifAbsentPut: [ OrderedCollection new ].
	entries add: anEntry
]

{ #category : #events }
CoStatistics >> logCancelCompletionFromTypedToken: typedToken inClass: aClassName withDynamicExtent: isDynamicExtent [
	
	"We have a matrix indexed by class name and dynamic extent or not.
	Classes are indexed with a dictionary.
	Being in a dynamic extent or not is inside an array.
	We store an average inside."
	| d1 average |
	d1 := cancelledCompletions
		at: aClassName
		ifAbsentPut: [ Array new: 2 ].
	average := d1 at: isDynamicExtent asBit + 1.
	average ifNil: [ d1 at: isDynamicExtent asBit + 1 put: (average := CoIncrementalAverage new) ].
	average incrementBy: typedToken size
]

{ #category : #accessing }
CoStatistics >> numberOfCancels [
	
	^ cancelledCompletions sumNumbers: [ :cancelledCompletionsInClass | 
		self numberOfCancelsByClassCompletions: cancelledCompletionsInClass ]
]

{ #category : #accessing }
CoStatistics >> numberOfCancelsByClass: aClassName [ 
	
	^ self numberOfCancelsByClassCompletions: (cancelledCompletions
		at: aClassName
		ifAbsent: [ ^ 0 ])
]

{ #category : #accessing }
CoStatistics >> numberOfCancelsByClassCompletions: cancelledCompletionsInClass [
	
	^ cancelledCompletionsInClass sum: [ :e |
		e ifNil: [ 0 ] ifNotNil: [ e size ] ]
]
