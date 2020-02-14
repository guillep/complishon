Class {
	#name : #ComplishonMockEnvironment,
	#superclass : #Object,
	#instVars : [
		'globals'
	],
	#category : #'Complishon-Tests'
}

{ #category : #accessing }
ComplishonMockEnvironment >> globals [
	^ globals
]

{ #category : #accessing }
ComplishonMockEnvironment >> globals: anObject [
	globals := anObject
]
