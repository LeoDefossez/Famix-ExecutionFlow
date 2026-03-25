Class {
	#name : 'FamixExecutionFlowJavaJTEImporter',
	#superclass : 'FamixExecutionFlowAbstractImporter',
	#instVars : [
		'filename',
		'model',
		'createdReference',
		'createdMethods'
	],
	#category : 'Famix-ExecutionFlow-Importer',
	#package : 'Famix-ExecutionFlow-Importer'
}

{ #category : 'api' }
FamixExecutionFlowJavaJTEImporter class >> initialize [

	self registerExternalDropHandler
]

{ #category : 'as yet unclassified' }
FamixExecutionFlowJavaJTEImporter class >> registerExternalDropHandler [
	ExternalDropHandler registerHandler: (ExternalDropHandler type: nil extension: #tr action: [ :fileReference |
				 (self import: fileReference)
					 install;
					 inspect ])
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> createMethodCall: aDictionary [
	"NOTE : IT IS IMPORTANT TO FOLLOW THE STEPS
		1. Method
		2. Arguments
		3. Receiver
		BECAUSE THE JAVA EXTRACTOR NEED FOLLOW THIS EXACT ORDER TO CREATE ALREADY FOUND REFERENCES"

	| call |
	call := model newIndirectMethodCall.

	aDictionary
		at: #method
		ifPresent: [ :methodDict |
		call method: (self ensureCreateMethod: methodDict) ]
		ifAbsent: [ Error signal: 'MethodCall has no method' ].

	self
		createArguments: (aDictionary at: #arguments)
		forTraceMethod: call.

	(aDictionary at: #receiver) ifNotNil: [ :receiver |
		call receiver: (self createReceiver: receiver) ].
	call method: (self createMethod: (aDictionary at: #method)).

	^ call
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> ensureCreateMethod: aDictionary [

	^ createdMethods
		  at: (aDictionary at: #signature)
		  ifAbsentPut: [ self instantiateMethodFrom: aDictionary ]
]

{ #category : 'instance creation' }
FamixExecutionFlowJavaJTEImporter >> instantiateMethodFrom: aDictionnary [

	| methodType method |
	methodType := self chooseMethodTypeFrom: aDictionnary.
	method := (model add: (methodType named: (aDictionnary at: #name))) isStub: true.

	method isClassSide: (aDictionnary at: #isClassSide).
	method parentType: (self createType: (aDictionnary at: #parentType)).
	method signature: (aDictionnary at: #signature).

	(self createParameters: (aDictionnary at: #parameters)) do: [ :param | method addParameter: param ].
	^ method
]

{ #category : 'as yet unclassified' }
FamixExecutionFlowJavaJTEImporter >> intialize [

	createdReference := Dictionary new.
	createdMethods := Dictionary new
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> read: json [
	"Instantiate the JavaCallStack model from a json object"

	| calls valueIndependents |
	json
		ifEmpty: [ Error signal: 'The json file is empty' ]
		ifNotEmpty: [
			model := FamixEFModel new
				         name: filename;
				         yourself.

			valueIndependents := json at: #valueIndependents.
			calls := json at: #Lines.

			calls do: [ :aCall |
				valueIndependents ifTrue: [ createdReference := Dictionary new ].
				self createMethodCall: aCall ].
			"reset moose name to make sure no error appear"
			model entities do: #resetMooseName ]
]

{ #category : 'instance creation' }
FamixExecutionFlowJavaJTEImporter >> readFrom: aFileReference [
	"Read the file reference as a json file and start the import as a JavaCallStack model"

	| reader |
	filename := aFileReference basename.
	reader := NeoJSONReader on: aFileReference readStream.
	self read: reader next.
	reader close.

	^ model
]
