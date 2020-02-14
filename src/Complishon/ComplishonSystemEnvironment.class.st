Class {
	#name : #ComplishonSystemEnvironment,
	#superclass : #Object,
	#category : #'Complishon-SystemIntegration'
}

{ #category : #accessing }
ComplishonSystemEnvironment >> globals [
	
	^ Smalltalk globals keys
]
