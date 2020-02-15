Class {
	#name : #BasicComplishonTest,
	#superclass : #TestCase,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
BasicComplishonTest >> context [
	| innerNode |
	RBMethodNode
		selector: #foo
		arguments: (#( methodArgument ) collect: [ :e | RBVariableNode named: e ])
		body: (RBSequenceNode
			temporaries: (#( methodTemporary ) collect: [ :e | RBVariableNode named: e ])
			statements: {RBBlockNode
				arguments: (#(blockArgument) collect: [ :e | RBVariableNode named: e ])
				body: (RBSequenceNode
					temporaries: (#(blockTemporary) collect: [ :e | RBVariableNode named: e ])
					statements: { innerNode := RBVariableNode named: '' })}).
	^ ComplishonContext new
		complishonClass:
			(ComplishonMockClass new
				instanceVariables: {'a' . 'b' . 'c'};
				selectors: #(ma mb mc);
				classVariables: #(Ca Cb Cc);
				yourself);
		complishonEnvironment:
			(ComplishonMockEnvironment new
				globals: {'A' . 'B' . 'C'};
				yourself);
		astNode: innerNode;
		yourself.
]
