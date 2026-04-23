Class {
	#name : 'FamixEFVEntity',
	#superclass : 'MooseEntity',
	#category : 'Famix-ExecutionFlow-Value-Entities-Entities',
	#package : 'Famix-ExecutionFlow-Value-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FamixEFVEntity class >> annotation [

	<FMClass: #Entity super: #MooseEntity>
	<package: #'Famix-ExecutionFlow-Value-Entities'>
	<generated>
	<abstract>
	^ self
]

{ #category : 'testing' }
FamixEFVEntity class >> isAbstract [

	<generated>
	^ self == FamixEFVEntity
]

{ #category : 'meta' }
FamixEFVEntity class >> metamodel [

	<generated>
	^ FamixEFVModel metamodel
]
