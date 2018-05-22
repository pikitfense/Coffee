   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE

   MAP
     MODULE('COFFEE_BC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('COFFEE001.CLW')
Main                   PROCEDURE   !Wizard Application for C:\share\Source10\Coffee\Coffee.dct
     END
   END

SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

!region File Declaration
Suppliers            FILE,DRIVER('MSSQL'),OWNER('PGHLT0466,Coffee,'),NAME('dbo.Suppliers'),PRE(Sup),BINDABLE,THREAD !                    
Record                   RECORD,PRE()
ID                          LONG                           !                    
Name                        CSTRING(51)                    !                    
email                       CSTRING(151)                   !                    
Phone                       CSTRING(15)                    !                    
website                     CSTRING(250)                   !                    
                         END
                     END                       

Control              FILE,DRIVER('TOPSPEED'),NAME('Control.tps'),PRE(Control),CREATE,BINDABLE,THREAD !                    
KControlId               KEY(Control:ControlId),NOCASE,PRIMARY !                    
Record                   RECORD,PRE()
ControlId                   LONG                           !                    
ClientName                  STRING(41)                     !                    
                         END
                     END                       

!endregion

Access:Suppliers     &FileManager,THREAD                   ! FileManager for Suppliers
Relate:Suppliers     &RelationManager,THREAD               ! RelationManager for Suppliers
Access:Control       &FileManager,THREAD                   ! FileManager for Control
Relate:Control       &RelationManager,THREAD               ! RelationManager for Control

FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
GlobalErrorStatus    ErrorStatusClass,THREAD
GlobalErrors         ErrorClass                            ! Global error manager
INIMgr               INIClass                              ! Global non-volatile storage manager
GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END


  CODE
  GlobalErrors.Init(GlobalErrorStatus)
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
  INIMgr.Init('.\Coffee.INI', NVD_INI)                     ! Configure INIManager to use INI file
  DctInit
  Main
  INIMgr.Update
  INIMgr.Kill                                              ! Destroy INI manager
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher


Dictionary.Construct PROCEDURE

  CODE
  IF THREAD()<>1
     DctInit()
  END


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()

