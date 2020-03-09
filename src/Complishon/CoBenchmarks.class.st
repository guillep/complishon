Class {
	#name : #CoBenchmarks,
	#superclass : #Object,
	#instVars : [
		'scope',
		'results',
		'completionBenchs',
		'builder'
	],
	#category : #'Complishon-Statistics'
}

{ #category : #running }
CoBenchmarks class >> runFor: aClass [ 
	
	^ self new
		scope: aClass;
		run
]

{ #category : #inspector }
CoBenchmarks >> accuracyForCompletionIndex: completionIndexRange withPrefixSize: prefixSize [
	
	^ ((completionIndexRange sum: [ :index |
		completionBenchs at: index at: prefixSize ifAbsent: [ 0 ]
	]) / (self totalEntriesPerPrefixSize: prefixSize)) asFloat
]

{ #category : #benchmarks }
CoBenchmarks >> benchCallsite: aRBMessageNode [ 
	
	| completion |
	aRBMessageNode methodNode methodClass.
	completion := builder
		complishonContext: (CoBenchmarkContext new callsite: aRBMessageNode);
		buildComplishon.
	
	2 to: (aRBMessageNode selector size min: 8) do: [ :index | | prefix candidates completionIndex previousResultsPerIndexPerPrefixSize |
		prefix := aRBMessageNode selector copyFrom: 1 to: index.
		completion filterWithString: prefix.
		candidates := completion first: 10.
		completionIndex := candidates indexOf: prefix.
		
		previousResultsPerIndexPerPrefixSize := completionBenchs
			at: completionIndex
			at: prefix size
			ifAbsent: [ 0 ].
		completionBenchs
			at: completionIndex
			at: prefix size
			put: previousResultsPerIndexPerPrefixSize + 1
	]
	
]

{ #category : #accessing }
CoBenchmarks >> builder: aCompletionBuilder [
	
	builder := aCompletionBuilder
]

{ #category : #inspector }
CoBenchmarks >> completionIndexes [
	
	^ { 1 to: 1.
	  2 to: 2.
	  3 to: 3.
	  4 to: 10.
	  0 to: 0.
	}
]

{ #category : #inspector }
CoBenchmarks >> gtResultsTableIn: composite [
	<gtInspectorPresentationOrder: 1>
	| table |
	table := composite table title: 'Results'.
	"columns"
	table column: 'Prefix' evaluated: [ :completionIndexRange | | label |
		label := '% '.
		label := label, (completionIndexRange size = 1
			ifTrue: [ 
				{ 'fail' . '1st' . '2nd' . '3rd' } at: completionIndexRange first + 1 ]
			ifFalse: [ completionIndexRange first asString , '-', completionIndexRange second asString ]).
		label ].
	self prefixSizes do: [ :prefixSize |
		table column: prefixSize asString evaluated: [ :completionIndexRange | | float | 
			float := self accuracyForCompletionIndex: completionIndexRange withPrefixSize: prefixSize.
			(float * 100) roundUpTo: 0.01
		]
	].
	"rows"
	table display: [ 
		self completionIndexes
	].
	^ table
]

{ #category : #initialization }
CoBenchmarks >> initialize [

	super initialize.
	completionBenchs := Dictionary new
]

{ #category : #inspector }
CoBenchmarks >> prefixSizes [

	^ 2 to: 8
]

{ #category : #running }
CoBenchmarks >> run [
	
	scope methodsDo: [ :method |
		method ast nodesDo: [ :node |
			node isMessage ifTrue: [ self benchCallsite: node ]
		]
	]
]

{ #category : #accessing }
CoBenchmarks >> scope: aClass [ 
	scope := aClass
]

{ #category : #inspector }
CoBenchmarks >> totalEntriesPerPrefixSize: aPrefixSize [

	^ completionBenchs sum: [ :benchsPerPrefix | benchsPerPrefix at: aPrefixSize ifAbsent: [ 0 ] ]
]
