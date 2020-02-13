Class {
	#name : #ComplishonMockClass,
	#superclass : #Object,
	#instVars : [
		'instanceVariables'
	],
	#category : #Complishon
}

{ #category : #configuration }
ComplishonMockClass >> addInstanceVariable: aString [ 
	
	instanceVariables := instanceVariables copyWith: aString
]

{ #category : #accessing }
ComplishonMockClass >> instanceVariables [
	^ instanceVariables
]

{ #category : #accessing }
ComplishonMockClass >> instanceVariables: anObject [
	instanceVariables := anObject
]
