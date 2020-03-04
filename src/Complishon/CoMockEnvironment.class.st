Class {
	#name : #CoMockEnvironment,
	#superclass : #Object,
	#instVars : [
		'globals'
	],
	#category : #'Complishon-Tests'
}

{ #category : #accessing }
CoMockEnvironment >> globals [
	^ globals
]

{ #category : #accessing }
CoMockEnvironment >> globals: anObject [
	globals := anObject
]
