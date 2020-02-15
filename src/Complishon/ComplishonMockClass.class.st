Class {
	#name : #ComplishonMockClass,
	#superclass : #Object,
	#instVars : [
		'instanceVariables',
		'selectors'
	],
	#category : #'Complishon-Tests'
}

{ #category : #configuration }
ComplishonMockClass >> addInstanceVariable: aString [ 
	
	instanceVariables := instanceVariables copyWith: aString
]

{ #category : #initialization }
ComplishonMockClass >> initialize [

	super initialize.
	selectors := OrderedCollection new
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

{ #category : #accessing }
ComplishonMockClass >> selectors [
	^ selectors
]

{ #category : #accessing }
ComplishonMockClass >> selectors: aCollection [ 
	selectors := aCollection
]

{ #category : #enumerating }
ComplishonMockClass >> selectorsDo: aBlockClosure [ 
	
	selectors do: aBlockClosure
]
