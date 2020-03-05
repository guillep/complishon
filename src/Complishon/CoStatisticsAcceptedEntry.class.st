Class {
	#name : #CoStatisticsAcceptedEntry,
	#superclass : #CoStatisticsEntry,
	#instVars : [
		'completedEntry',
		'source',
		'index'
	],
	#category : #'Complishon-Statistics'
}

{ #category : #accessing }
CoStatisticsAcceptedEntry >> completedEntry [
	^ completedEntry
]

{ #category : #accessing }
CoStatisticsAcceptedEntry >> completedEntry: anObject [
	completedEntry := anObject
]

{ #category : #accessing }
CoStatisticsAcceptedEntry >> index [
	^ index
]

{ #category : #accessing }
CoStatisticsAcceptedEntry >> index: anObject [
	index := anObject
]

{ #category : #accessing }
CoStatisticsAcceptedEntry >> source [
	^ source
]

{ #category : #accessing }
CoStatisticsAcceptedEntry >> source: anObject [
	source := anObject
]
