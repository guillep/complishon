Class {
	#name : #ComplishonContext,
	#superclass : #Object,
	#instVars : [
		'complishonClass',
		'complishonEnvironment'
	],
	#category : #Complishon
}

{ #category : #accessing }
ComplishonContext >> complishonClass [
	^ complishonClass
]

{ #category : #accessing }
ComplishonContext >> complishonClass: anObject [
	complishonClass := anObject
]

{ #category : #accessing }
ComplishonContext >> complishonEnvironment [
	^ complishonEnvironment
]

{ #category : #accessing }
ComplishonContext >> complishonEnvironment: anObject [
	complishonEnvironment := anObject
]
