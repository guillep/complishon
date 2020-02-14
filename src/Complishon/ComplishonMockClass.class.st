Class {
	#name : #ComplishonMockClass,
	#superclass : #Object,
	#instVars : [
		'instanceVariables'
	],
	#category : #'Complishon-Tests'
}

{ #category : #configuration }
ComplishonMockClass >> addInstanceVariable: aString [ 
	
	instanceVariables := instanceVariables copyWith: aString
]

{ #category : #accessing }
ComplishonMockClass >> instVarNames [
	
	^ self instanceVariables
]

{ #category : #accessing }
ComplishonMockClass >> instanceVariables [
	^ instanceVariables
]

{ #category : #accessing }
ComplishonMockClass >> instanceVariables: anObject [
	instanceVariables := anObject
]
