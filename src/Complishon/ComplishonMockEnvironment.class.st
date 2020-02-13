Class {
	#name : #ComplishonMockEnvironment,
	#superclass : #Object,
	#instVars : [
		'globals'
	],
	#category : #Complishon
}

{ #category : #accessing }
ComplishonMockEnvironment >> globals [
	^ globals
]

{ #category : #accessing }
ComplishonMockEnvironment >> globals: anObject [
	globals := anObject
]
