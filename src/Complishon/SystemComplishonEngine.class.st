Class {
	#name : #SystemComplishonEngine,
	#superclass : #Object,
	#instVars : [
		'menuMorph',
		'editor',
		'inverseMapping',
		'context',
		'completionDelay'
	],
	#category : #'Complishon-SystemIntegration'
}

{ #category : #testing }
SystemComplishonEngine class >> isCompletionEnabled [
	^true
]

{ #category : #smartis }
SystemComplishonEngine >> captureNavigationKeys [
	^ NECPreferences captureNavigationKeys
]

{ #category : #menu }
SystemComplishonEngine >> closeMenu [

	self stopCompletionDelay.
	menuMorph
		ifNotNil: [ menuMorph delete ].
	menuMorph := nil.
]

{ #category : #accessing }
SystemComplishonEngine >> context [
	^ context
]

{ #category : #accessing }
SystemComplishonEngine >> editor [
	^ editor
]

{ #category : #events }
SystemComplishonEngine >> handleKeystrokeAfter: aKeyboardEvent editor: aParagraphEditor [ 
	(aParagraphEditor isNil or: [ self isMenuOpen not ])
		ifTrue: [ ^ self ].
		
	aParagraphEditor atCompletionPosition 
		ifFalse: [ ^ self closeMenu ].

	context narrowWith: aParagraphEditor wordAtCaret.
	menuMorph narrowCompletion.
	(context isNil or: [ context hasEntries not])
		ifTrue: [ ^self closeMenu ]
]

{ #category : #events }
SystemComplishonEngine >> handleKeystrokeBefore: aKeyboardEvent editor: anEditor [
	"I return a boolean. 
	true when I have handled the event and no futher processing is needed by the caller.
	
	This method would be cleaner if splitted."

	| keyCharacter controlKeyPressed commandKeyPressed |
	self setEditor: anEditor.
	keyCharacter := aKeyboardEvent keyCharacter.
	controlKeyPressed := aKeyboardEvent controlKeyPressed.
	commandKeyPressed := aKeyboardEvent commandKeyPressed.
	self isMenuOpen
		ifFalse: [ ^ self handleKeystrokeWithoutMenu: aKeyboardEvent ].
	(keyCharacter = Character home and: [ self captureNavigationKeys ])
		ifTrue: [ 
			menuMorph home.
			^ true ].
	(keyCharacter = Character end and: [ controlKeyPressed not and: [ self captureNavigationKeys ] ])
		ifTrue: [ 
			menuMorph end.
			^ true ].
	(keyCharacter = Character arrowRight and: [commandKeyPressed and: [ self captureNavigationKeys ]])
		ifTrue: [ 
			menuMorph showDetail.
			^ true ].
	(keyCharacter = Character arrowLeft  and: [commandKeyPressed and: [ self captureNavigationKeys ]])
		ifTrue: [ ^ self leftArrow ].
	keyCharacter = Character arrowUp
		ifTrue: [ 
			menuMorph moveUp.
			^ true ].
	keyCharacter = Character arrowDown
		ifTrue: [ 
			menuMorph moveDown.
			^ true ].
	keyCharacter = Character pageUp
		ifTrue: [ 
			menuMorph pageUp.
			^ true ].
	keyCharacter = Character pageDown
		ifTrue: [ 
			menuMorph pageDown.
			^ true ].
	(keyCharacter = Character cr and: [ NECPreferences useEnterToAccept ])
		ifTrue: [ 
			menuMorph insertSelected
				ifTrue: [ ^ true ] ].
	keyCharacter = Character tab
		ifTrue: [ 
			NECPreferences expandPrefixes
				ifFalse: [ 
					menuMorph insertSelected
						ifTrue: [ ^ true ] ]
				ifTrue: [ 
					menuMorph insertCommonPrefixOrSelected
						ifTrue: [ ^ true ] ] ].
	keyCharacter = Character backspace
		ifTrue: [ 
			editor isCaretBehindChar
				ifFalse: [ self closeMenu ].
			^ false ].
	(controlKeyPressed not & aKeyboardEvent commandKeyPressed not
		and: [ aKeyboardEvent keyCharacter isCompletionCharacter ])
		ifFalse: [ 
			self closeMenu.
			^ keyCharacter = Character escape ].
	^ false
]

{ #category : #events }
SystemComplishonEngine >> handleKeystrokeWithoutMenu: aKeyboardEvent [
	"I handle resetting the completion menu, and I return true when I handle an event."
	
	self editor atCompletionPosition ifFalse: [ 
		^ (self smartInputWithEvent: aKeyboardEvent ) notNil ].	
	
	self stopCompletionDelay.

	(NECPreferences popupShowWithShortcut matches: {aKeyboardEvent})
		 ifTrue: [
			self openMenu.
			^true ].
		
	(self smartInputWithEvent: aKeyboardEvent )
		ifNotNil: [ ^true ].

	NECPreferences popupShowAutomatic ifTrue: [
		(aKeyboardEvent anyModifierKeyPressed not 
		and: [ aKeyboardEvent keyCharacter isCompletionCharacter ]) 
			ifTrue: [ self resetCompletionDelay ] ].
	
	^ false
]

{ #category : #smarties }
SystemComplishonEngine >> invalidateEditorMorph [
	editor morph invalidRect: editor morph bounds.
]

{ #category : #menu }
SystemComplishonEngine >> isMenuOpen [
	^menuMorph notNil
]

{ #category : #testing }
SystemComplishonEngine >> isScripting [

	^ self editor 
		ifNotNil: [ self editor isScripting ]
		ifNil: [ false ]
]

{ #category : #menu }
SystemComplishonEngine >> menuClosed [
	menuMorph := nil.
	context := nil.
]

{ #category : #menu }
SystemComplishonEngine >> menuMorphClass [
	^ NECMenuMorph
]

{ #category : #smarties }
SystemComplishonEngine >> newSmartCharacterInsertionStringForLeft: left right: right [
	((NECPreferences smartCharactersWithDoubleSpace includes: left) or: [
	(NECPreferences smartCharactersWithDoubleSpace includes: right)])
	ifTrue: [ 
		^ String with: left with: Character space with: Character space  with: right ].
	
	((NECPreferences smartCharactersWithSingleSpace includes: left) or: [
	(NECPreferences smartCharactersWithSingleSpace includes: right)])
	ifTrue: [ 
		^ String with: left with: Character space  with: right ].
	
	^ String with: left with: right
]

{ #category : #menu }
SystemComplishonEngine >> openMenu [
	| theMenu class |
	self stopCompletionDelay.
	
	class := editor model ifNotNil: [ :model | model selectedClassOrMetaClass ].

	context := SystemComplishonContext
				engine: self
				class: class
				source: editor text string
				position: editor caret - 1.

	theMenu := self menuMorphClass
				engine: self
				position: (editor selectionPosition: context completionToken).
				
	theMenu isClosed
		ifFalse: [ menuMorph := theMenu ].
	
	(context isNil or: [ context hasEntries not ])
		ifTrue: [ ^self closeMenu ].
]

{ #category : #process }
SystemComplishonEngine >> resetCompletionDelay [
	"Open the popup after 100ms and only after certain characters"
	self stopCompletionDelay.
	self isMenuOpen ifTrue: [ ^ self ].
	editor atCompletionPosition ifFalse: [ ^ self ].
	
	completionDelay := [
			(Delay forMilliseconds: NECPreferences popupAutomaticDelay) wait.
			UIManager default defer:  [ 
				editor atCompletionPosition ifTrue: [ self openMenu ]]
		] fork.
	
]

{ #category : #accessing }
SystemComplishonEngine >> setEditor: anObject [
	editor ifNotNil: [  
		"make sure we unsubscribe from old editor"
		editor morph ifNotNil: [:m | m announcer unsubscribe: self] ].
	editor := anObject.
	editor morph onAnnouncement: MorphLostFocus send: #closeMenu to: self.
]

{ #category : #smartis }
SystemComplishonEngine >> smartBackspace [
	| opposite currentText currentEditor smartCharacter |
	
	currentEditor := editor.
	currentEditor hasSelection
		ifTrue: [ ^ false ].
	
	currentText := currentEditor text.
	smartCharacter := currentText at: currentEditor startIndex - 1 ifAbsent: [ ^ false ].	"take the opposite"
	
	opposite := self smartCharacterOppositeOf: smartCharacter ifAbsent: [ ^false ].	"test if the next char is opposite"
	
	opposite = (currentText at: currentEditor stopIndex ifAbsent: [ ^ false ])
		ifFalse: [ ^ false ].	"test if there is an extra opposite to remove"
	
	(self 
		smartNeedExtraRemoveIn: currentText 
		for: smartCharacter 
		opposite: opposite 
		at: currentEditor startIndex)
			ifFalse: [  ^ false ].	
			
	currentEditor closeTypeIn.
	
	currentEditor 
		selectInvisiblyFrom: currentEditor startIndex - 1 
		to: currentEditor stopIndex.
	currentEditor replaceSelectionWith: currentEditor nullText.
	
	self invalidateEditorMorph.
	
	^ true
]

{ #category : #smartis }
SystemComplishonEngine >> smartCharacterOppositeOf: char ifAbsent: aBlock [
	^(self smartCharactersMapping at: char ifAbsent: [ ^aBlock value ]) key
]

{ #category : #smartis }
SystemComplishonEngine >> smartCharacterPairFor: char ifAbsent: aBlock [
	| left right |
	
	left := self smartCharactersMapping at: char ifPresent: [ char ] ifAbsent: [ 
		self smartInverseMapping at: char ifPresent: [:key | key ] ifAbsent: [ ^aBlock value ]].
	
	right := self smartCharacterOppositeOf: left ifAbsent: [ ^aBlock value ].
	
 	^ left -> right
]

{ #category : #smartis }
SystemComplishonEngine >> smartCharacterShouldClose: char [
	^(self smartCharactersMapping at: char ifAbsent: [ ^false ]) value
]

{ #category : #smartis }
SystemComplishonEngine >> smartCharacterWithEvent: anEvent [
	"char is extracted from anEvent, anEvent is passed because we may need it.
	We may remove char if this is not costly."

	| opposite previous next char insertion insertionCenter matchingPair |
	char := anEvent keyCharacter.
	editor hasSelection
		ifTrue: [ 
			"we selected a piece of text and we type the same character that previously, so
		we unwrap it"
			"we selected a piece of text if the character is not a special one we do nothing."
			matchingPair := self smartCharacterPairFor: char ifAbsent: [  ^nil ].	"else we wrap the selection"	"editor replaceSelectionWith: (String with: char) , (editor selection) , (String with: opposite)."	"ugly logic it should be encapsulated in the editor "
			
			editor encloseWith: matchingPair.
			self invalidateEditorMorph.
			^ true ].	"we are not in a selection"
			
	(self smartCharacterShouldClose: char)	
		ifFalse: [ 
			"if the character is not a special character"
			self smartInverseMapping at: char ifAbsent: [ ^ nil ].	"if the character is not a closing special character do nothing"	"The character is special"
			editor blinkPrevParen: char.
			(editor nextCharacterIfAbsent: [ ^ nil ]) = char
				ifFalse: [ ^ nil ].	"do not get this test but if we comment it out we cannot type closing ) anymore"
			editor selectFrom: editor startIndex + 1 to: editor startIndex.
			self invalidateEditorMorph.
			^ true ].
		
	opposite := self smartCharacterOppositeOf: char ifAbsent: [ ^nil ].
	previous := editor previousCharacterIfAbsent: [ Character space ].
	next := editor nextCharacterIfAbsent: [ Character space ].
	insertion := next isSeparator
				ifFalse: [ char asString ]
				ifTrue: [ 
					previous isSeparator
						ifFalse: [ char asString ]
						ifTrue: [ self newSmartCharacterInsertionStringForLeft: char right: opposite ]].
	editor replaceSelectionWith: insertion.
	insertionCenter := insertion size // 2 max: 1.
	editor selectFrom: editor startIndex + insertionCenter to: editor startIndex + (insertionCenter - 1).
	self invalidateEditorMorph.
	^ true
]

{ #category : #smartis }
SystemComplishonEngine >> smartCharacters [
	^ NECPreferences smartCharacters 
]

{ #category : #smartis }
SystemComplishonEngine >> smartCharactersMapping [
	^ NECPreferences smartCharactersMapping 
]

{ #category : #smartis }
SystemComplishonEngine >> smartInputWithEvent: anEvent [
	"aCharacter is extracted from anEvent, anEvent is passed because we may need it.
	We may remove aCharacter if this is not costly."
	
	self smartCharacters 
		ifFalse: [ ^ nil ].
	
	anEvent keyCharacter = Character backspace
		ifTrue: [ self smartBackspace ifTrue: [ ^ true ]].
		
	
	^ self smartCharacterWithEvent: anEvent
]

{ #category : #smartis }
SystemComplishonEngine >> smartInverseMapping [
	^ inverseMapping ifNil: [ 
		inverseMapping := Dictionary new.
		self smartCharactersMapping
			keysAndValuesDo: [ :char :inverse | inverseMapping at: inverse key put: char ].
		inverseMapping ]
]

{ #category : #smartis }
SystemComplishonEngine >> smartNeedExtraRemoveIn: currentText for: smartCharacter opposite: opposite at: position [
	"Test if we need to remove an extra character when removing a smart character (any kind of smart character)"
	
	smartCharacter = opposite
		ifTrue: [ 
			(self smartNeedExtraRemoveIn: currentText for: opposite)
				ifFalse: [ ^ false ] ]
		ifFalse: [ 
			(self
				smartNeedExtraRemovePairedIn: currentText
				for: smartCharacter
				opposite: opposite
				at: position)
					ifFalse: [ ^false ] ].
	^ true
]

{ #category : #smartis }
SystemComplishonEngine >> smartNeedExtraRemovePairedIn: currentText for: smartCharacter opposite: opposite at: position [
	"Test if we need to remove an extra character when removed a paired smart character.
	 A paired smart character is any smart character who has an opposite who is diferent to itself: [], ()"
	
	| startIndex countSmart countOpposite |
	
	countSmart := 0.
	countOpposite := 0.
	startIndex := self
		smartStartIndexIn: currentText
		for: smartCharacter
		opposite: opposite
		at: position.
		
	(currentText allButFirst: startIndex) 
		do: [ :char | 
			char = smartCharacter
				ifTrue: [ countSmart := countSmart + 1 ].
			char = opposite
				ifTrue: [ countOpposite := countOpposite + 1 ] ].
	
	(countSmart > countOpposite and: [ (countOpposite - countSmart) odd ])
		ifTrue: [ ^ false ].
		
	^true
]

{ #category : #smartis }
SystemComplishonEngine >> smartStartIndexIn: currentText for: smartCharacter  opposite: opposite  at: position [
	
	(position - 1) to: 1 by: -1 do: [ :index | | char | 
		char := currentText at: index.
		(char = smartCharacter or: [ char = opposite])
			 ifFalse: [ ^index ] ].
	
	^0
]

{ #category : #process }
SystemComplishonEngine >> stopCompletionDelay [

    completionDelay ifNotNil: [ 
        completionDelay isTerminating ifFalse: [ completionDelay terminate ] ]
]
