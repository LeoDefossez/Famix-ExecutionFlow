Extension { #name : 'FamixEFArgument' }

{ #category : '*Famix-ExecutionFlow-Value-Entities-accessing' }
FamixEFArgument >> value [
	"Relation named: #value type: #FamixValueOfType opposite: #argumentInMethodCall"

	<generated>
	<FMComment: 'The arguments of the call.'>
	<FMProperty: #value type: #FamixValueOfType opposite: #argumentInMethodCall>
	<package: #'Famix-ExecutionFlow-Value-Entities'>
	^ self attributeAt: #value ifAbsent: [ nil ]
]

{ #category : '*Famix-ExecutionFlow-Value-Entities-accessing' }
FamixEFArgument >> value: anObject [

	<generated>
	self attributeAt: #value put: (FMMultivalueLink on: self update: #argumentInMethodCall from: self value to: anObject).
]
