

   MEMBER('Coffee.clw')                                    ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('BROWSESUPPLIERS_COFFEE.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('UPDATESUPPLIERS_COFFEE.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Browse the Suppliers file
!!! </summary>
BrowseSuppliers PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Suppliers)
                       PROJECT(Sup:ID)
                       PROJECT(Sup:Name)
                       PROJECT(Sup:email)
                       PROJECT(Sup:Phone)
                       PROJECT(Sup:website)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
Sup:ID                 LIKE(Sup:ID)                   !List box control field - type derived from field
Sup:Name               LIKE(Sup:Name)                 !List box control field - type derived from field
Sup:email              LIKE(Sup:email)                !List box control field - type derived from field
Sup:Phone              LIKE(Sup:Phone)                !List box control field - type derived from field
Sup:website            LIKE(Sup:website)              !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the Suppliers file'),AT(,,324,180),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('BrowseSuppliers'),SYSTEM
                       LIST,AT(8,30,308,142),USE(?Browse:1),HVSCROLL,FORMAT('64R(2)|M~ID~C(0)@n-14@80L(2)|M~Na' & |
  'me~L(2)@s50@80L(2)|M~email~L(2)@s150@48L(2)|M~Phone~L(2)@s11@44L(2)|M~website~L(2)@s10@'), |
  FROM(Queue:Browse:1),IMM,MSG('Browsing the Suppliers file')
                       BUTTON('&View'),AT(108,176,49,14),USE(?View:2),LEFT,ICON('WAVIEW.ICO'),FLAT,HIDE,MSG('View Record'), |
  TIP('View Record')
                       BUTTON('&Insert'),AT(161,140,49,14),USE(?Insert:3),LEFT,ICON('WAINSERT.ICO'),FLAT,HIDE,MSG('Insert a Record'), |
  TIP('Insert a Record')
                       BUTTON('&Change'),AT(214,140,49,14),USE(?Change:3),LEFT,ICON('WACHANGE.ICO'),DEFAULT,FLAT, |
  HIDE,MSG('Change the Record'),TIP('Change the Record')
                       BUTTON('&Delete'),AT(267,140,49,14),USE(?Delete:3),LEFT,ICON('WADELETE.ICO'),FLAT,HIDE,MSG('Delete the Record'), |
  TIP('Delete the Record')
                       SHEET,AT(4,4,316,172),USE(?CurrentTab)
                         TAB('&1) Record Order'),USE(?Tab:2)
                         END
                       END
                       BUTTON('&Close'),AT(218,162,49,14),USE(?Close),LEFT,ICON('WACLOSE.ICO'),FLAT,HIDE,MSG('Close Window'), |
  TIP('Close Window')
                       BUTTON('&Help'),AT(271,162,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,HIDE,MSG('See Help Window'), |
  STD(STD:Help),TIP('See Help Window')
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('BrowseSuppliers')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Suppliers.Open                                    ! File Suppliers used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Suppliers,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW1.AddField(Sup:ID,BRW1.Q.Sup:ID)                      ! Field Sup:ID is a hot field or requires assignment from browse
  BRW1.AddField(Sup:Name,BRW1.Q.Sup:Name)                  ! Field Sup:Name is a hot field or requires assignment from browse
  BRW1.AddField(Sup:email,BRW1.Q.Sup:email)                ! Field Sup:email is a hot field or requires assignment from browse
  BRW1.AddField(Sup:Phone,BRW1.Q.Sup:Phone)                ! Field Sup:Phone is a hot field or requires assignment from browse
  BRW1.AddField(Sup:website,BRW1.Q.Sup:website)            ! Field Sup:website is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseSuppliers',QuickWindow)              ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: UpdateSuppliers
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.ToolbarItem.HelpButton = ?Help
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Suppliers.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseSuppliers',QuickWindow)           ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    UpdateSuppliers
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END
  SELF.ViewControl = ?View:2                               ! Setup the control used to initiate view only mode


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

