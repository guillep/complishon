Class {
	#name : #ComplishonMockClass,
	#superclass : #Object,
	#instVars : [
		'instanceVariables',
		'selectors',
		'classVariables',
		'superclass'
	],
	#category : #'Complishon-Tests'
}

{ #category : #configuration }
ComplishonMockClass >> addInstanceVariable: aString [ 
	
	instanceVariables := instanceVariables copyWith: aString
]

{ #category : #accessing }
ComplishonMockClass >> classVarNames [
	
	^ classVariables
]

{ #category : #accessing }
ComplishonMockClass >> classVariables: aCollection [

	classVariables := aCollection
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
ComplishonMockClass >> instanceSide [
	
	^ self
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

{ #category : #accessing }
ComplishonMockClass >> superclass [
	
	^ superclass
]

{ #category : #accessing }
ComplishonMockClass >> superclass: aComplishonMockClass [ 
	
	superclass := aComplishonMockClass
]
