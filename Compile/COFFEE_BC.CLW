  MEMBER('Coffee.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('Coffee_BC0.CLW')
Coffee_BC0:DctInit             PROCEDURE
Coffee_BC0:DctKill             PROCEDURE
Coffee_BC0:FilesInit           PROCEDURE
    END
  END

DctInit PROCEDURE
  CODE
  Coffee_BC0:DctInit
  Coffee_BC0:FilesInit


DctKill PROCEDURE
  CODE
  Coffee_BC0:DctKill

