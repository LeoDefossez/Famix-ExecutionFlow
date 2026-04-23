Class {
	#name : 'FamixExecutionFlowValueGenerator',
	#superclass : 'FamixMetamodelGenerator',
	#instVars : [
		'methodCall',
		'tOfType',
		'argument'
	],
	#category : 'Famix-ExecutionFlow-Value-Generator',
	#package : 'Famix-ExecutionFlow-Value-Generator'
}

{ #category : 'accessing' }
FamixExecutionFlowValueGenerator class >> packageName [

	<ignoreForCoverage>
	^ #'Famix-ExecutionFlow-Value-Entities'
]

{ #category : 'accessing' }
FamixExecutionFlowValueGenerator class >> prefix [

	<ignoreForCoverage>
	^ #FamixEFV
]

{ #category : 'accessing' }
FamixExecutionFlowValueGenerator class >> submetamodels [

	^ {
		  FamixExecutionFlowGenerator.
		  FamixValueGenerator }
]

{ #category : 'definition' }
FamixExecutionFlowValueGenerator >> defineClasses [

	methodCall := self remoteEntity: #MethodCall withPrefix: #FamixEF.

	argument := builder
		            newClassNamed: #Argument
		            comment: 'An argument of a method call.
This entity is reified due to the fact that an argument can appear multiple times in the same method call.'
]

{ #category : 'definition' }
FamixExecutionFlowValueGenerator >> defineRelations [
	"Relations to FamixValue"

	((methodCall property: #receiver) comment:
		 'The receiver of the call.')
	*- ((tOfType property: #receiverInMethodCall) comment:
			 'The calls that use me as receiver.').

	((methodCall property: #arguments) comment:
		 'The arguments of the call.')
	-* ((argument property: #methodCall) comment:
			 'The call that use me as an argument.').

	((argument property: #value) comment:
		 'The value of an argument in a method call.')
	*- ((tOfType property: #argumentInMethodCalls) comment:
			 'The call arguments that use me as a value.').

	((methodCall property: #result) comment: 'The result of the call.')
	*- ((tOfType property: #resultInMethodCall) comment:
			 'The calls that returns me.')
]

{ #category : 'definition' }
FamixExecutionFlowValueGenerator >> defineTraits [

	tOfType := self remoteEntity: #OfType withPrefix: #FamixValue
]
