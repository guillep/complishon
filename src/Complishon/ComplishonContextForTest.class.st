Class {
	#name : #ComplishonContextForTest,
	#superclass : #Object,
	#instVars : [
		'complishonClass',
		'complishonEnvironment',
		'astNode'
	],
	#category : #'Complishon-Tests'
}

{ #category : #accessing }
ComplishonContextForTest >> complishonClass [
	^ complishonClass
]

{ #category : #accessing }
ComplishonContextForTest >> complishonClass: anObject [
	complishonClass := anObject
]

{ #category : #accessing }
ComplishonContextForTest >> complishonEnvironment [
	^ complishonEnvironment
]

{ #category : #accessing }
ComplishonContextForTest >> complishonEnvironment: anObject [
	complishonEnvironment := anObject
]

{ #category : #accessing }
ComplishonContextForTest >> complishonPackage [
	
	^ self complishonClass package
]

{ #category : #accessing }
ComplishonContextForTest >> copyWithClass: aClass [

	^ self copy
		complishonClass: aClass;
		yourself
]

{ #category : #accessing }
ComplishonContextForTest >> environmentAt: aKey ifPresent: aBlock [

	self complishonEnvironment at: aKey ifPresent: aBlock
]
