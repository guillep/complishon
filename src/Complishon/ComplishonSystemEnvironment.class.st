Class {
	#name : #ComplishonSystemEnvironment,
	#superclass : #Object,
	#category : #Complishon
}

{ #category : #accessing }
ComplishonSystemEnvironment >> globals [
	
	^ Smalltalk globals keys
]
