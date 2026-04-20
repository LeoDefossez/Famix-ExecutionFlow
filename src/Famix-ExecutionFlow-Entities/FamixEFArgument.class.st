"
An argument of a method call in the context of a dynamic call graph.
This entity is reified due to the fact that, an argument can appear in multiple method calls, and multiple times in the same method call.

## Relations
======================

### Other
| Relation | Origin | Opposite | Type | Comment |
|---|
| `methodCall` | `FamixEFArgument` | `arguments` | `FamixEFMethodCall` | The calls that use me as an argument.|



"
Class {
	#name : 'FamixEFArgument',
	#superclass : 'FamixEFEntity',
	#instVars : [
		'#methodCall => FMOne type: #FamixEFMethodCall opposite: #arguments'
	],
	#category : 'Famix-ExecutionFlow-Entities-Entities',
	#package : 'Famix-ExecutionFlow-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FamixEFArgument class >> annotation [

	<FMClass: #Argument super: #FamixEFEntity>
	<package: #'Famix-ExecutionFlow-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FamixEFArgument >> methodCall [
	"Relation named: #methodCall type: #FamixEFMethodCall opposite: #arguments"

	<generated>
	<FMComment: 'The calls that use me as an argument.'>
	^ methodCall
]

{ #category : 'accessing' }
FamixEFArgument >> methodCall: anObject [

	<generated>
	methodCall := anObject
]
