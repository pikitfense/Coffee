  MEMBER('Coffee.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
Coffee_BC0:DctInit    PROCEDURE
Coffee_BC0:DctKill    PROCEDURE
Coffee_BC0:FilesInit  PROCEDURE
  END

Hide:Access:Suppliers CLASS(FileManager),TYPE              ! FileManager for Suppliers
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Suppliers CLASS(RelationManager),TYPE          ! RelationManager for Suppliers
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Control  CLASS(FileManager),TYPE               ! FileManager for Control
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Control  CLASS(RelationManager),TYPE           ! RelationManager for Control
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


_Hide:Access:Suppliers &Hide:Access:Suppliers,AUTO,THREAD
_Hide:Relate:Suppliers &Hide:Relate:Suppliers,AUTO,THREAD
_Hide:Access:Control &Hide:Access:Control,AUTO,THREAD
_Hide:Relate:Control &Hide:Relate:Control,AUTO,THREAD


Coffee_BC0:DctInit PROCEDURE
  CODE
  _Hide:Access:Suppliers &= NEW(Hide:Access:Suppliers)
  _Hide:Relate:Suppliers &= NEW(Hide:Relate:Suppliers)
  _Hide:Access:Control &= NEW(Hide:Access:Control)
  _Hide:Relate:Control &= NEW(Hide:Relate:Control)
  Relate:Suppliers &= _Hide:Relate:Suppliers
  Relate:Control &= _Hide:Relate:Control


Coffee_BC0:FilesInit PROCEDURE
  CODE
  _Hide:Relate:Suppliers.Init
  _Hide:Relate:Control.Init


Coffee_BC0:DctKill PROCEDURE
  CODE
  _Hide:Relate:Suppliers.Kill
  DISPOSE(_Hide:Relate:Suppliers)
  _Hide:Relate:Control.Kill
  DISPOSE(_Hide:Relate:Control)


Hide:Relate:Suppliers.Init PROCEDURE
  CODE
  _Hide:Access:Suppliers.Init
  SELF.Init(Access:Suppliers,1)


Hide:Access:Suppliers.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Sup:Record
  SELF.FileNameValue = 'Suppliers'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Suppliers
  PARENT.Init
  Access:Suppliers &= SELF


Hide:Access:Suppliers.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Suppliers &= NULL                                 ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Suppliers.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Suppliers,GlobalErrors)
    SELF.Create = 0
    SELF.LockRecover = 10
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Suppliers.Kill PROCEDURE

  CODE
  _Hide:Access:Suppliers.Kill                              ! Kill the file manager
  PARENT.Kill
  Relate:Suppliers &= NULL                                 ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Suppliers)                          ! destroy the file manager


Hide:Relate:Control.Init PROCEDURE
  CODE
  _Hide:Access:Control.Init
  SELF.Init(Access:Control,1)


Hide:Access:Control.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Control:Record
  SELF.FileNameValue = 'Control'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Control
  PARENT.Init
  Access:Control &= SELF


Hide:Access:Control.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Control &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Control.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Control,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Control:KControlId,'Control:KControlId',1)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Control.Kill PROCEDURE

  CODE
  _Hide:Access:Control.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:Control &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Control)                            ! destroy the file manager

