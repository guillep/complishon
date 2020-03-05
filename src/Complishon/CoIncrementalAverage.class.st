Class {
	#name : #CoIncrementalAverage,
	#superclass : #Object,
	#instVars : [
		'size',
		'value'
	],
	#category : #'Complishon-Statistics'
}

{ #category : #accessing }
CoIncrementalAverage >> incrementBy: aSize [
	
	size := size + 1.
	value := value + ((aSize - value) / size)
]

{ #category : #accessing }
CoIncrementalAverage >> initialize [

	super initialize.
	value := 0.
	size := 0
]

{ #category : #accessing }
CoIncrementalAverage >> size [

	^ size
]

{ #category : #accessing }
CoIncrementalAverage >> value [
	
	^ value
]
