Extension { #name : 'FamixValueOfType' }

{ #category : '*Famix-ExecutionFlow-Value-Entities-accessing' }
FamixValueOfType >> argumentInMethodCall [
	"Relation named: #argumentInMethodCall type: #FamixEFVArgument opposite: #value"

	<generated>
	<FMComment: 'The calls that use me as an argument.'>
	<derived>
	<FMProperty: #argumentInMethodCall type: #FamixEFVArgument opposite: #value>
	<package: #'Famix-ExecutionFlow-Value-Entities'>
	^ self attributeAt: #argumentInMethodCall ifAbsentPut: [ FMMultivalueLink on: self opposite: #value: ]
]

{ #category : '*Famix-ExecutionFlow-Value-Entities-accessing' }
FamixValueOfType >> argumentInMethodCall: anObject [

	<generated>
	self argumentInMethodCall value: anObject
]

{ #category : '*Famix-ExecutionFlow-Value-Entities-accessing' }
FamixValueOfType >> receiverInMethodCall [
	"Relation named: #receiverInMethodCall type: #FamixEFMethodCall opposite: #receiver"

	<generated>
	<FMComment: 'The calls that use me as receiver.'>
	<derived>
	<FMProperty: #receiverInMethodCall type: #FamixEFMethodCall opposite: #receiver>
	<package: #'Famix-ExecutionFlow-Value-Entities'>
	^ self attributeAt: #receiverInMethodCall ifAbsentPut: [ FMMultivalueLink on: self opposite: #receiver: ]
]

{ #category : '*Famix-ExecutionFlow-Value-Entities-accessing' }
FamixValueOfType >> receiverInMethodCall: anObject [

	<generated>
	self receiverInMethodCall value: anObject
]

{ #category : '*Famix-ExecutionFlow-Value-Entities-accessing' }
FamixValueOfType >> resultInMethodCall [
	"Relation named: #resultInMethodCall type: #FamixEFMethodCall opposite: #result"

	<generated>
	<FMComment: 'The calls that returns me.'>
	<derived>
	<FMProperty: #resultInMethodCall type: #FamixEFMethodCall opposite: #result>
	<package: #'Famix-ExecutionFlow-Value-Entities'>
	^ self attributeAt: #resultInMethodCall ifAbsentPut: [ FMMultivalueLink on: self opposite: #result: ]
]

{ #category : '*Famix-ExecutionFlow-Value-Entities-accessing' }
FamixValueOfType >> resultInMethodCall: anObject [

	<generated>
	self resultInMethodCall value: anObject
]
