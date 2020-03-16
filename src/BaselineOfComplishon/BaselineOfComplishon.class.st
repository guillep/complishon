Class {
	#name : #BaselineOfComplishon,
	#superclass : #BaselineOf,
	#category : #BaselineOfComplishon
}

{ #category : #baselines }
BaselineOfComplishon >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ 
		spec package: 'Complishon' ]
]
