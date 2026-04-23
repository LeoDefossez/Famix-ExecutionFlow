"
An argument of a method call.
This entity is reified due to the fact that an argument can appear multiple times in the same method call.

## Relations
======================

### Other
| Relation | Origin | Opposite | Type | Comment |
|---|
| `methodCall` | `FamixEFVArgument` | `arguments` | `FamixEFMethodCall` | The call that use me as an argument.|
| `value` | `FamixEFVArgument` | `argumentInMethodCall` | `FamixValueOfType` | The arguments of the call.|



"
Class {
	#name : 'FamixEFVArgument',
	#superclass : 'FamixEFVEntity',
	#category : 'Famix-ExecutionFlow-Value-Entities-Entities',
	#package : 'Famix-ExecutionFlow-Value-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FamixEFVArgument class >> annotation [

	<FMClass: #Argument super: #FamixEFVEntity>
	<package: #'Famix-ExecutionFlow-Value-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FamixEFVArgument >> methodCall [
	"Relation named: #methodCall type: #FamixEFMethodCall opposite: #arguments"

	<generated>
	<FMComment: 'The call that use me as an argument.'>
	<FMProperty: #methodCall type: #FamixEFMethodCall opposite: #arguments>
	^ self attributeAt: #methodCall ifAbsent: [ nil ]
]

{ #category : 'accessing' }
FamixEFVArgument >> methodCall: anObject [

	<generated>
	self attributeAt: #methodCall put: (FMMultivalueLink on: self update: #arguments from: self methodCall to: anObject).
]

{ #category : 'accessing' }
FamixEFVArgument >> value [
	"Relation named: #value type: #FamixValueOfType opposite: #argumentInMethodCall"

	<generated>
	<FMComment: 'The arguments of the call.'>
	<FMProperty: #value type: #FamixValueOfType opposite: #argumentInMethodCall>
	^ self attributeAt: #value ifAbsent: [ nil ]
]

{ #category : 'accessing' }
FamixEFVArgument >> value: anObject [

	<generated>
	self attributeAt: #value put: (FMMultivalueLink on: self update: #argumentInMethodCall from: self value to: anObject).
]
