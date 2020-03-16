Extension { #name : #CompletionEngine }

{ #category : #'*Complishon' }
CompletionEngine >> doItContext [
	"Rubric sends the morph as requestor to the compiler.
	We need to use it to keep the same semantics..."

	^ self editor model doItContext
]

{ #category : #'*Complishon' }
CompletionEngine >> doItRequestor [

	^ self editor morph
]

{ #category : #'*Complishon' }
CompletionEngine >> variableBindingNames [

	self doItRequestor ifNil: [ ^ #() ].
	^ self doItRequestor model variableBindings keys
]
