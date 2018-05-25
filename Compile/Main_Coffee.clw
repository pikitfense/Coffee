

   MEMBER('Coffee.clw')                                    ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('MAIN_COFFEE.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('BROWSESUPPLIERS_COFFEE.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('CONTROLEDIT_COFFEE.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Frame
!!! Wizard Application for C:\share\Source10\Coffee\Coffee.dct
!!! </summary>
Main PROCEDURE 

SQLOpenWindow        WINDOW('Initializing Database'),AT(,,208,26),FONT('Microsoft Sans Serif',8,,FONT:regular),CENTER,GRAY,DOUBLE
                       STRING('This process could take several seconds.'),AT(27,12)
                       IMAGE(Icon:Connect),AT(4,4,23,17)
                       STRING('Please wait while the program connects to the database.'),AT(27,3)
                     END

AppFrame             APPLICATION('Application'),AT(,,505,318),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,CENTER,ICON('WAFRAME.ICO'),MAX,STATUS(-1,80,120,45),SYSTEM,IMM
                       MENUBAR,USE(?Menubar)
                         MENU('&File'),USE(?FileMenu)
                           ITEM('&Print Setup ...'),USE(?PrintSetup),MSG('Setup printer'),STD(STD:PrintSetup)
                           ITEM,USE(?SEPARATOR1),SEPARATOR
                           ITEM('E&xit'),USE(?Exit),MSG('Exit this application'),STD(STD:Close)
                         END
                         MENU('&Edit'),USE(?EditMenu)
                           ITEM('Cu&t'),USE(?Cut),MSG('Cut Selection To Clipboard'),STD(STD:Cut)
                           ITEM('&Copy'),USE(?Copy),MSG('Copy Selection To Clipboard'),STD(STD:Copy)
                           ITEM('&Paste'),USE(?Paste),MSG('Paste From Clipboard'),STD(STD:Paste)
                         END
                         MENU('&Browse'),USE(?BrowseMenu)
                           ITEM('Browse the Suppliers file'),USE(?BrowseSuppliers),MSG('Browse Suppliers')
                         END
                         MENU('&Window'),USE(?WindowMenu),STD(STD:WindowList)
                           ITEM('T&ile'),USE(?Tile),MSG('Arrange multiple opened windows'),STD(STD:TileWindow)
                           ITEM('&Cascade'),USE(?Cascade),MSG('Arrange multiple opened windows'),STD(STD:CascadeWindow)
                           ITEM('&Arrange Icons'),USE(?Arrange),MSG('Arrange the icons for minimized windows'),STD(STD:ArrangeIcons)
                         END
                         MENU('&Utility'),USE(?MENU1)
                           ITEM('Edit Control File'),USE(?ITEM1)
                         END
                         MENU('&Help'),USE(?HelpMenu)
                           ITEM('&Contents'),USE(?Helpindex),MSG('View the contents of the help file'),STD(STD:HelpIndex)
                           ITEM('&Search for Help On...'),USE(?HelpSearch),MSG('Search for help on a subject'),STD(STD:HelpSearch)
                           ITEM('&How to Use Help'),USE(?HelpOnHelp),MSG('Provides general instructions on using help'), |
  STD(STD:HelpOnHelp)
                         END
                       END
                       TOOLBAR,AT(0,0,505,16),USE(?Toolbar)
                         BUTTON,AT(4,2,14,14),USE(?Toolbar:Top, Toolbar:Top),ICON('WAVCRFIRST.ICO'),DISABLE,FLAT,TIP('Go to the ' & |
  'First Page')
                         BUTTON,AT(18,2,14,14),USE(?Toolbar:PageUp, Toolbar:PageUp),ICON('WAVCRPRIOR.ICO'),DISABLE, |
  FLAT,TIP('Go to the Prior Page')
                         BUTTON,AT(32,2,14,14),USE(?Toolbar:Up, Toolbar:Up),ICON('WAVCRUP.ICO'),DISABLE,FLAT,TIP('Go to the ' & |
  'Prior Record')
                         BUTTON,AT(46,2,14,14),USE(?Toolbar:Locate, Toolbar:Locate),ICON('WAFIND.ICO'),DISABLE,FLAT, |
  TIP('Locate record')
                         BUTTON,AT(60,2,14,14),USE(?Toolbar:Down, Toolbar:Down),ICON('WAVCRDOWN.ICO'),DISABLE,FLAT, |
  TIP('Go to the Next Record')
                         BUTTON,AT(74,2,14,14),USE(?Toolbar:PageDown, Toolbar:PageDown),ICON('WAVCRNEXT.ICO'),DISABLE, |
  FLAT,TIP('Go to the Next Page')
                         BUTTON,AT(88,2,14,14),USE(?Toolbar:Bottom, Toolbar:Bottom),ICON('WAVCRLAST.ICO'),DISABLE,FLAT, |
  TIP('Go to the Last Page')
                         BUTTON,AT(102,2,14,14),USE(?Toolbar:Select, Toolbar:Select),ICON('WAMARK.ICO'),DISABLE,FLAT, |
  TIP('Select This Record')
                         BUTTON,AT(116,2,14,14),USE(?Toolbar:Insert, Toolbar:Insert),ICON('WAINSERT.ICO'),DISABLE,FLAT, |
  TIP('Insert a New Record')
                         BUTTON,AT(130,2,14,14),USE(?Toolbar:Change, Toolbar:Change),ICON('WACHANGE.ICO'),DISABLE,FLAT, |
  TIP('Edit This Record')
                         BUTTON,AT(144,2,14,14),USE(?Toolbar:Delete, Toolbar:Delete),ICON('WADELETE.ICO'),DISABLE,FLAT, |
  TIP('Delete This Record')
                         BUTTON,AT(158,2,14,14),USE(?Toolbar:History, Toolbar:History),ICON('WADITTO.ICO'),DISABLE, |
  FLAT,TIP('Previous value')
                         BUTTON,AT(172,2,14,14),USE(?Toolbar:Help, Toolbar:Help),ICON('WAVCRHELP.ICO'),DISABLE,FLAT, |
  TIP('Get Help')
                       END
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
Menu::Menubar ROUTINE                                      ! Code for menu items on ?Menubar
Menu::FileMenu ROUTINE                                     ! Code for menu items on ?FileMenu
Menu::EditMenu ROUTINE                                     ! Code for menu items on ?EditMenu
Menu::BrowseMenu ROUTINE                                   ! Code for menu items on ?BrowseMenu
  CASE ACCEPTED()
  OF ?BrowseSuppliers
    START(BrowseSuppliers, 050000)
  END
Menu::WindowMenu ROUTINE                                   ! Code for menu items on ?WindowMenu
Menu::MENU1 ROUTINE                                        ! Code for menu items on ?MENU1
  CASE ACCEPTED()
  OF ?ITEM1
    START(ControlEdit, 25000)
  END
Menu::HelpMenu ROUTINE                                     ! Code for menu items on ?HelpMenu

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Main')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = 1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SETCURSOR(Cursor:Wait)
  OPEN(SQLOpenWindow)
  ACCEPT
    IF EVENT() = Event:OpenWindow
  Relate:Suppliers.Open                                    ! File Suppliers used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
      POST(EVENT:CloseWindow)
    END
  END
  CLOSE(SQLOpenWindow)
  SETCURSOR()
  SELF.Open(AppFrame)                                      ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('Main',AppFrame)                            ! Restore window settings from non-volatile store
  SELF.SetAlerts()
      AppFrame{PROP:TabBarVisible}  = False
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
    INIMgr.Update('Main',AppFrame)                         ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?Toolbar:Top
    OROF ?Toolbar:PageUp
    OROF ?Toolbar:Up
    OROF ?Toolbar:Locate
    OROF ?Toolbar:Down
    OROF ?Toolbar:PageDown
    OROF ?Toolbar:Bottom
    OROF ?Toolbar:Select
    OROF ?Toolbar:Insert
    OROF ?Toolbar:Change
    OROF ?Toolbar:Delete
    OROF ?Toolbar:History
    OROF ?Toolbar:Help
      IF SYSTEM{PROP:Active} <> THREAD()
        POST(EVENT:Accepted,ACCEPTED(),SYSTEM{Prop:Active} )
        CYCLE
      END
    ELSE
      DO Menu::Menubar                                     ! Process menu items on ?Menubar menu
      DO Menu::FileMenu                                    ! Process menu items on ?FileMenu menu
      DO Menu::EditMenu                                    ! Process menu items on ?EditMenu menu
      DO Menu::BrowseMenu                                  ! Process menu items on ?BrowseMenu menu
      DO Menu::WindowMenu                                  ! Process menu items on ?WindowMenu menu
      DO Menu::MENU1                                       ! Process menu items on ?MENU1 menu
      DO Menu::HelpMenu                                    ! Process menu items on ?HelpMenu menu
    END
  ReturnValue = PARENT.TakeAccepted()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

