Class {
	#name : #ComplishonContext,
	#superclass : #Object,
	#instVars : [
		'complishonClass',
		'complishonEnvironment',
		'astNode'
	],
	#category : #'Complishon-Core'
}

{ #category : #accessing }
ComplishonContext >> astNode: aNode [ 
	astNode := aNode
]

{ #category : #accessing }
ComplishonContext >> complishonASTNode [
	
	^ astNode
]

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

{ #category : #accessing }
ComplishonContext >> complishonPackage [
	
	^ self complishonClass package
]

{ #category : #accessing }
ComplishonContext >> copyWithClass: aClass [

	^ self copy
		complishonClass: aClass;
		yourself
]
