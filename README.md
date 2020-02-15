# Complishon

Experimental code completion engine using generators.
Instead of query the entire system and generate lots of potentially intermediate collections that we need to concatenate, copy, grow, iterate all those sub-collections in order.
Generators provide a stream-like access to those collections (and sequences of collections) without scanning the full system eagerly.

This package is meant for Pharo 9.0 for now. It is highly experimental, there are things that may break :).

## Installing

If you want to install it globally in the system, evaluate the following expression:
```smalltalk
RubSmalltalkEditor completionEngineClass: SystemComplishonEngine
```

Otherwise, you can add it per spec text component as follows:

```smalltalk
p := SpCodePresenter new
	behavior: MyClassToAutoComplete;
	syntaxHighlight: true;
	completionEngine: SystemComplishonEngine new.;
	yourself.
p openWithSpec.
```

## Architecture

This completion engine is done out of three main components:
 - lazy fetchers implemented using generators,
 - a completion object that works as a result-set
 - and several completion heuristics that are decided depending on the code being completed by looking at the AST.
 
 ### Fetchers
 
 Fetchers are subclasses of  `ComplishonFetcher`. They need to define the method `#entriesInContext: aContext do: aBlock` iterating a collection.
 The fetcher framework will take care of creating a streaming API for it using generators.
 For example, a simple fetcher can be created and used with:
 
```smalltalk
ComplishonFetcher subclass: #MyFetcher
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'Complishon-Core'
  
MyFetcher >> entriesInContext: aContext do: aBlock [
  1 to: 10000000000 do: aBlock
]

MyFetcher new next >>> 1.
```
#### Basic Fetchers

A simple generic fetcher works on a collection.

```smalltalk
GenericComplishonFetcher onCollection: #( a b b a c )
```

And an empty fetcher is useful to provide no results

```smalltalk
EmptyComplishonFetcher new
```

#### Fetcher combinators

The fetchers above can be combined between them with several simple combinators.
A **sequence** of fetchers, created with the message `#,`, fetches first the elements in the first fetcher, then in the second one.

```smalltalk
InstanceVariableComplishonFetcher new, GlobalVariableComplishonFetcher new
```

A **filter** fetcher, created with the message `#select:`, decorates another fetcher and filters it with a block.

```smalltalk
InstanceVariableComplishonFetcher new select: [ :e | "a condition..." ]
```

A **no-repetition** fetcher, created with the message `#withoutRepetition`, decorates another fetcher and filters those elements that were already returned previously by himself.

```smalltalk
PackageImplementedMessagesComplishonFetcher new select: [ :e | "a condition..." ]
```

### Fetchers for code completion

In addition, this engine provides already fetchers to iterate the following:
 - `InstanceVariableComplishonFetcher`: instance variables of a class
 - `ClassVariableComplishonFetcher`: class variables of a class
 - `ClassImplementedMessagesComplishonFetcher`: messages implemented by a class
 - `GlobalVariableComplishonFetcher`: global variables in an environment
 - `MethodVariableComplishonFetcher`: variables accessible to an AST node (in order)
 - `PackageImplementedMessagesComplishonFetcher`: messages sent in a package

For code completion, another combinator shows useful to iterate a fetcher up a class hierarchy: `HierarchyComplishonFetcher`.
This hierarchy fetcher decorates a `ClassBasedComplishonFetcher` (i.e., a `ClassImplementedMessagesComplishonFetcher`, a `InstanceVariableComplishonFetcher` or a `ClassImplementedMessagesComplishonFetcher`), and can be created with the message `#forHierarchy`.

## Completion ResultSet

The `Complishon` object will store a `ComplishonContext` (knowing the current selection and status of the UI to autocomplete) and a fetcher.
It then lazily fetches and internally store objects on demand:

```smalltalk
c := Complishon
	onContext: self context
	fetcher: InstanceVariableComplishonFetcher new.

"The first time it will fetch 20 elements from the fetcher and store them"
c first: 20.

"The second time it will just return the already stored elements"
c first: 20.

"Now it will fetch some more objects to have its 25"
c first: 25.
```

The `Complishon` object allows one to:
 - explicit fetch using `fetch:` and `fetchAll`
 - retrieve the results using `first`, `first:` and `results`
 - filter those results using `filterByString:`
 - query it with `hasMoreElements` and `notEmpty`
 
## Heuristics

When the autocompletion is invoked, it calculates how to autocomplete given the AST node where the caret is in the text editor.
The following piece of code shows examples of heuristics implemented in the prototype.

### Heuristics for messages

If the AST node is a message whose receiver is `self`, autocomplete all messages implemented in the hierarchy.
```smalltalk
(ClassImplementedMessagesComplishonFetcher new
		completionClass: complishonContext complishonClass;
		forHierarchy) withoutRepetition
```

If the AST node is a message whose receiver is `super`, autocomplete all messages implemented in the hierarchy starting from the superclass.
```smalltalk
(ClassImplementedMessagesComplishonFetcher new
		completionClass: complishonContext complishonClass superclass;
		forHierarchy) withoutRepetition
```

If the AST node is a message whose receiver is a class name like `OrderedCollection`, autocomplete all messages in the class-side hierarchy of that class.
```smalltalk
(ClassImplementedMessagesComplishonFetcher new
		completionClass: (Smalltalk globals at: aRBMessageNode receiver name) classSide;
		forHierarchy) withoutRepetition
```


If the AST node is a message whose receiver is a variable that has type information in its name name, like `anOrderedCollection`, autocomplete all messages in the instance-side hierarchy of guessed class.
Then continue with normal completion.
There are two cases: variables starting with `a` such as `aPoint` and variables starting with `an` such as `anASTCache`.
```smalltalk
Smalltalk globals at: aRBMessageNode receiver name allButFirst asSymbol ifPresent: [ :class |
			^ (ClassImplementedMessagesComplishonFetcher new
				completionClass: class;
				forHierarchy), PackageImplementedMessagesComplishonFetcher new  ].
Smalltalk globals at: (aRBMessageNode receiver name allButFirst: 2) asSymbol ifPresent: [ :class |
			^ (ClassImplementedMessagesComplishonFetcher new
				completionClass: class;
				forHierarchy), PackageImplementedMessagesComplishonFetcher new  ]
].
```

If all the above fail, autocomplete all messages used in the current package.
Chances are we are going to send them again.
```smalltalk
	^ PackageImplementedMessagesComplishonFetcher new
```

### Heuristics for Method signature

When autocompleting the name of a new method, chances are we want to override a method in the hierarchy, or to reimplement a method polymorphic with the ones existing in the current package. 
```smalltalk
(self newSuperMessageInHierarchyFetcher,
				PackageImplementedMessagesComplishonFetcher new)
					withoutRepetition
```

### Heuristics for variables

Variables accessed by an instance are first the ones in the method, then the ones in the hierarchy.

```smalltalk
instanceAccessible := MethodVariableComplishonFetcher new,
	(InstanceVariableComplishonFetcher new
		completionClass: complishonContext complishonClass)
			forHierarchy ].
```

Then, variables accessed by an instance are also the ones in the class variables and globals.
```smalltalk
globallyAccessible := (ClassVariableComplishonFetcher new
	completionClass: complishonContext complishonClass)
		forHierarchy,
      GlobalVariableComplishonFetcher new.
```

However, invert the order if the variable we are typing starts in uppercase.
```smalltalk	
	^ aRBVariableNode name first isUppercase
		ifFalse: [ instanceAccessible , globallyAccessible ]
		ifTrue: [ globallyAccessible, instanceAccessible ]
```
