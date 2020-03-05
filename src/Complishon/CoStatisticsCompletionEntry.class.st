Class {
	#name : #CoStatisticsCompletionEntry,
	#superclass : #Object,
	#instVars : [
		'necEntry',
		'index',
		'heuristic'
	],
	#category : #'Complishon-Statistics'
}

{ #category : #'instance creation' }
CoStatisticsCompletionEntry class >> on: aNECEntry [
	
	^ self new
		necEntry: aNECEntry;
		yourself
]

{ #category : #accessing }
CoStatisticsCompletionEntry >> = anEntry [
 
	^ self contents = anEntry contents
]

{ #category : #activating }
CoStatisticsCompletionEntry >> activateOn: aCoCompletionContext [ 
	
	| entry |
	entry := CoStatisticsAcceptedEntry new
		index: index;
		source: heuristic;
		typedToken: aCoCompletionContext completionToken;
		completedEntry: self contents.
	CoStatistics uniqueInstance logAcceptEntry: entry.
	necEntry activateOn: aCoCompletionContext
]

{ #category : #accessing }
CoStatisticsCompletionEntry >> contents [
	
	^ necEntry contents
]

{ #category : #accessing }
CoStatisticsCompletionEntry >> heuristic [
	^ heuristic
]

{ #category : #accessing }
CoStatisticsCompletionEntry >> heuristic: anObject [
	heuristic := anObject
]

{ #category : #accessing }
CoStatisticsCompletionEntry >> hightlightSymbol [

	^ necEntry hightlightSymbol
]

{ #category : #accessing }
CoStatisticsCompletionEntry >> index [
	^ index
]

{ #category : #accessing }
CoStatisticsCompletionEntry >> index: anInteger [ 
	
	index := anInteger
]

{ #category : #accessing }
CoStatisticsCompletionEntry >> necEntry [
	^ necEntry
]

{ #category : #accessing }
CoStatisticsCompletionEntry >> necEntry: aNECEntry [ 
	"self haltIf: [ aNECEntry isKindOf: self class ]."
	necEntry := aNECEntry
]
