Class {
	#name : #CoStatisticsCompletionContext,
	#superclass : #CoCompletionContext,
	#category : #'Complishon-Statistics'
}

{ #category : #activating }
CoStatisticsCompletionContext >> activateEntryAt: anIndex [

	^ (self entries at: anIndex)
		index: anIndex;
		activateOn: self
]
