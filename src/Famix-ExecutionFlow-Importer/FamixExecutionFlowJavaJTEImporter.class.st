Class {
	#name : 'FamixExecutionFlowJavaJTEImporter',
	#superclass : 'FamixExecutionFlowAbstractImporter',
	#instVars : [
		'filename',
		'model',
		'createdReference',
		'createdMethods',
		'createdTypes',
		'createdSourcesPackages',
		'defaultPackage'
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
	ExternalDropHandler registerHandler: (ExternalDropHandler type: nil extension: #ef action: [ :fileReference |
				 (self import: fileReference)
					 install;
					 inspect ])
]

{ #category : 'instance creation' }
FamixExecutionFlowJavaJTEImporter >> chooseMethodTypeFrom: aDictionnary [

	aDictionnary at: #isParametric ifPresent: [ :bool | bool ifTrue: [ ^ FamixJavaParametricMethod ] ].
	^ FamixJavaMethod
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> createArguments: aDictionary forMethodCall: aTraceMethod [

	| argValuesDict |
	"FamixExecutionFlow does not have the principle of argument being accessible or not
	Default: accessible if not specified
	accessible := aDictionary at: #accessible ifAbsent: true."
	argValuesDict := aDictionary at: #argsValues ifAbsent: nil. "Default: accessible if not specified"

	argValuesDict ifNotNil: [
		argValuesDict do: [ :argDict |
			aTraceMethod addArgument: (self createValueFrom: argDict) ] ]
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
		forMethodCall: call.

	(aDictionary at: #receiver) ifNotNil: [ :receiver |
		call receiver: (self createReceiver: receiver forMethodCall: call) ].
	call method: (self ensureCreateMethod: (aDictionary at: #method)).

	^ call
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> createObjectAttribute: aDictionary [
	"Instantiate a field from a ClassReference"

	| field valueDict atMaxDepth |
	"FamixValue has no concept of max depth or accessibility
	accessible := aDictionary at: #accessible ifAbsent: [ true ]."
	atMaxDepth := aDictionary at: #atMaxDepth ifAbsent: [ false ].
	"hasValueKey := aDictionary includesKey: #value."
	"Default: nil if not specified"
	valueDict := aDictionary at: #value ifAbsent: [ nil ].

	"Checking if the field has a valid construction with accessibility
	Should be either
	- accessible and not at max depth and have a value
	- inaccessible or at max depth, and dont have a value
	isValid := atMaxDepth
		           ifTrue: [ hasValueKey not or: [ valueDict isNil ] ]
		           ifFalse: [ accessible = hasValueKey ].

	isValid ifFalse: [
		Error signal: 'Field has not a valid construction' ]."

	self flag: 'name of the attribute is currentyl lost'.
	field := FamixValueOfObjectAttribute new yourself.
	"name: (aDictionary at: #name);"
	"isAccessible: accessible;
		         isAtMaxDepth: atMaxDepth;"

	atMaxDepth ifFalse: [
		valueDict
			ifNil: [ field value: nil ]
			ifNotNil: [ field value: (self createValueFrom: valueDict) ] ].
	^ field
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> createPrimitiveValue: aDictionary [
	"Instantiate a PrimitiveValue"

	| primVal |
	primVal := model add: FamixValueOfPrimitiveType new.
	self
		createTypingFor: primVal
		with: (self ensureCreatePrimitiveType: (aDictionary at: #type)).
	primVal value: (aDictionary at: #value).
	^ primVal
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> createReceiver: aDictionary forMethodCall: call [

	aDictionary
		at: #reference
		ifPresent: [ :reference |
		^ self createRecursiveValueFrom: (aDictionary at: #reference) ].
	aDictionary at: #primitiveValue ifPresent: [ :primitive |
		Error signal:
			'Receiver should not be a primitiveType receiver value' ].
	Error signal: 'Unexcepted receiver value'
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> createRecursiveValueFrom: aDictionary [
	"Instantiate a ValueReference"

	| reference type uniqueId |
	uniqueId := aDictionary at: #uniqueId.

	"Check alreadyFound case"
	(aDictionary at: #alreadyFound ifAbsent: [ false ]) ifTrue: [
		^ createdReference at: uniqueId ifAbsent: [
			  Error signal:
				  'The objectReference with ID: ' , uniqueId asString
				  ,
				  ' is indicated to be already found, but is not in the saved references' ] ].

	"Ensure no duplicate creation"
	reference := createdReference
		             at: uniqueId
		             ifPresent: [
			             Error signal:
				             'Trying to create an object with ID: '
				             , uniqueId asString
				             ,
				             ' while an existing ObjectReference already has this ID' ]
		             ifAbsentPut: [
			             (self instantiateReferenceEntityFrom: aDictionary)
				             "uniqueID: uniqueId. FamixValue is not able to handle ids" ].

	"Fill reference"
	reference fillFrom: (aDictionary at: #refered) reader: self.



	type := self ensureCreateType: (aDictionary at: #type).

	self createTypingFor: reference with: type.

	^ reference
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> createTypingFor: anObject with: type [
	"Typing does not exist in moose 12"

	"^ anObject
		  typing: (model add: (FamixJavaEntityTyping new
						    declaredType: type;
						    yourself));
		  yourself"

	self flag: 'this will break with moose 13'.
	anObject isString ifFalse: [ anObject type: type ].
	^ anObject
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> createValueFrom: aDictionary [
	"Choose which subTypes of a Value should be instantiated"

	"Looking for either a reference or a primitive type, if neither are present throw an error"
	
	aDictionary ifNil:[^ self nilValue ].

	aDictionary
		at: #reference
		ifPresent: [ :reference |
		^ self createRecursiveValueFrom: reference ].

	aDictionary
		at: #primitiveValue
		ifPresent: [ :primitive | ^ self createPrimitiveValue: primitive ].

	Error signal: 'Unexcepted argument value'
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> createValueOfCollectionElementWith: aCollection [
	1halt.
	^ FamixValueOfCollectionElement new value:
		  (aCollection ifNotNil: [ self createValueFrom: aCollection ])
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> createValueOfCollectionWith: aCollection [

	^ FamixValueOfCollectionElement new value:
		  (aCollection ifNotNil: [ self createValueFrom: aCollection ])
]

{ #category : 'instance creation' }
FamixExecutionFlowJavaJTEImporter >> defaultPackage [

	^ createdSourcesPackages
		  at: '<Default Package>'
		  ifAbsentPut: [
		  defaultPackage := model newPackageNamed: '<Default Package>' ]
]

{ #category : 'instance creation' }
FamixExecutionFlowJavaJTEImporter >> ensureCreateClassNamed: aString [

	^ self ensureCreateClassNamed: aString withType: FamixJavaClass
]

{ #category : 'instance creation' }
FamixExecutionFlowJavaJTEImporter >> ensureCreateClassNamed: aString withType: aType [

	| sequence container name |
	sequence := (aString removeSuffix: '[]') splitOn: $..
	name := sequence last.

	container := self ensureCreatePackageFromStringCollection:
		             sequence allButLast.
	^ createdTypes at: name ifAbsentPut: [
		  model
			  add: ((aType named: name)
					   typeContainer: container;
					   isStub: true;
					   yourself) ]
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> ensureCreateMethod: aDictionary [

	^ createdMethods
		  at: (aDictionary at: #signature)
		  ifAbsentPut: [ self instantiateMethodFrom: aDictionary ]
]

{ #category : 'instance creation' }
FamixExecutionFlowJavaJTEImporter >> ensureCreatePackageFromStringCollection: aCollection [

	| currentParent |
	"if the collection is empty then return the default package"
	aCollection ifEmpty: [ ^ self defaultPackage ].

	"Search for the source package"
	currentParent := createdSourcesPackages
		                 at: aCollection first
		                 ifAbsentPut: [
		                 model add:
			                 (FamixJavaPackage named: aCollection first) ].

	"If we are in a source package, then return it now"
	aCollection size = 1 ifTrue: [ ^ currentParent ].

	"If in nested package create all and return the deepest one"
	aCollection allButFirst do: [ :each |
		currentParent := self
			                 ensureCreatePackageNamed: each
			                 withParent: currentParent ].
	^ currentParent
]

{ #category : 'instance creation' }
FamixExecutionFlowJavaJTEImporter >> ensureCreatePackageNamed: aString withParent: aPackage [

	^ aPackage childEntities
		  detect: [ :each | each name = aString ]
		  ifNone: [
			  (model add: (FamixJavaPackage named: aString))
				  parentPackage: aPackage;
				  yourself ]
]

{ #category : 'instance creation' }
FamixExecutionFlowJavaJTEImporter >> ensureCreateParametricClassNamed: aString [

	^ self ensureCreateClassNamed: aString withType: FamixJavaParametricClass
]

{ #category : 'instance creation' }
FamixExecutionFlowJavaJTEImporter >> ensureCreatePrimitiveType: aString [
	"Instantiate a PrimitiveType if not already on the model"

	| name |
	name := aString removeSuffix: '[]'.
	^ createdTypes at: name ifAbsentPut: [
		  (FamixJavaPrimitiveType named: name)
			  isStub: true;
			  yourself ]
]

{ #category : 'instance creation' }
FamixExecutionFlowJavaJTEImporter >> ensureCreateType: aCollection [

	aCollection isString ifTrue: [ ^ self ensureCreatePrimitiveType: aCollection ].
	aCollection isDictionary ifTrue: [
			aCollection
				at: #isParametric
				ifPresent: [ :bool | bool ifTrue: [ ^ self ensureCreateParametricClassNamed: (aCollection at: #name) ] ].
			^ self ensureCreateClassNamed: (aCollection at: #name) ].
	self error: 'should either be a String for a primitive type or a dictionary for a class'
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> fillValueOfCollection: aValueOfCollection with: aDictionary [

	aDictionary at: #atMaxDepth ifPresent: [ :value |
		value ifTrue: [
			aDictionary at: #elements ifPresent: [ :elems |
				elems ifNotEmpty: [
					Error signal: 'ArrayReference at max depth is containing value' ] ].
			^ aValueOfCollection ] ].
	(aDictionary at: 'elements') do: [ :elem |
		aValueOfCollection addValue:
			(self createValueOfCollectionWith: elem) ]
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> fillValueOfObject: aValueOfObject with: aDictionary [

	aDictionary at: #isPrepared ifPresent: [ :value |
		value ifFalse: [
			aDictionary at: #fields ifPresent: [ :elems |
				elems ifNotEmpty: [
					Error signal:
						'ClassReference is not prepared but still have fields informations' ] ].
			^ aValueOfObject ] ].

	(aDictionary at: 'fields')
		collect: [ :fieldDict |
		self createObjectAttribute: (fieldDict at: #field) ]
		thenDo: [ :object | aValueOfObject addValue: object ].
	^ self
]

{ #category : 'as yet unclassified' }
FamixExecutionFlowJavaJTEImporter >> initialize [

	model := FamixEFModel new.
	createdReference := Dictionary new.
	createdMethods := Dictionary new.
	createdTypes := Dictionary new.
	createdSourcesPackages := Dictionary new
]

{ #category : 'instance creation' }
FamixExecutionFlowJavaJTEImporter >> instantiateMethodFrom: aDictionnary [

	| methodType method |
	methodType := self chooseMethodTypeFrom: aDictionnary.
	method := (model add: (methodType named: (aDictionnary at: #name)))
		          isStub: true.

	method isClassSide: (aDictionnary at: #isClassSide).
	method parentType:
		(self ensureCreateType: (aDictionnary at: #parentType)).
	method signature: (aDictionnary at: #signature).
	
	"We don't really care about parameters since we got the signature"
	"(self createParameters: (aDictionnary at: #parameters)) do: [ :param | method addParameter: param ]."
	^ method
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> instantiateReferenceEntityFrom: aDictionary [

	| refered |
	refered := aDictionary at: #refered.
	refered isDictionary ifTrue: [
		refered
			at: #fields
			ifPresent: [ :fields | ^ FamixValueOfObject new ].
		refered
			at: #elements
			ifPresent: [ :elements | ^ FamixValueOfCollection new ] ].

	refered isString ifTrue: [ ^ FamixValueOfPrimitiveType new ].
	Error signal: 'Should either be String or dictionary'
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> nilType [
	"Instantiate a PrimitiveType if not already on the model"

	| name |
	name := 'null'.
	^ createdTypes at: 'null' ifAbsentPut: [
		  (FamixJavaPrimitiveType named: name)
			  isStub: true;
			  yourself ]
]

{ #category : 'meta-object-protocol' }
FamixExecutionFlowJavaJTEImporter >> nilValue [

	| primVal |
	primVal := model add: FamixValueOfPrimitiveType new.
	self createTypingFor: primVal with: self nilType.
	primVal value: nil.
	^ primVal
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
