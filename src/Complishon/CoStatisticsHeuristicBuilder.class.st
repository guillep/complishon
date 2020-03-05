Class {
	#name : #CoStatisticsHeuristicBuilder,
	#superclass : #CoHeuristicBuilder,
	#category : #'Complishon-Statistics'
}

{ #category : #building }
CoStatisticsHeuristicBuilder >> build [

	^ (heuristics collect: [ :each | CoStatisticsHeuristicWrapper new wrapped: each ])
		 reduceRight: [ :left :right | left next: right. left ]
]
