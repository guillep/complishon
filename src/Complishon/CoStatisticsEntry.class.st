Class {
	#name : #CoStatisticsEntry,
	#superclass : #Object,
	#instVars : [
		'typedToken',
		'contextClassName',
		'isDynamicContext'
	],
	#category : #'Complishon-Statistics'
}

{ #category : #testing }
CoStatisticsEntry class >> isAbstract [

	^ self == CoStatisticsEntry
]

{ #category : #accessing }
CoStatisticsEntry >> contextClassName [
	^ contextClassName
]

{ #category : #accessing }
CoStatisticsEntry >> contextClassName: anObject [
	contextClassName := anObject
]

{ #category : #accessing }
CoStatisticsEntry >> isDynamicContext [
	^ isDynamicContext
]

{ #category : #accessing }
CoStatisticsEntry >> isDynamicContext: anObject [
	isDynamicContext := anObject
]

{ #category : #accessing }
CoStatisticsEntry >> numberOfTypedCharacter [
	
	^ typedToken size
]

{ #category : #accessing }
CoStatisticsEntry >> typedToken [
	^ typedToken
]

{ #category : #accessing }
CoStatisticsEntry >> typedToken: anObject [
	typedToken := anObject
]
