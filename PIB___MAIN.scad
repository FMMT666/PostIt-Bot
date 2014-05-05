//
// PostIt-Bot, V0.4c
//
// 06/2013, 07/2013, 12/2013, 04/2014
// (C)CC-BY-SA, FMMT666(ASkr)
// www.askrprojects.net
//

//
// NOTES:
//
//   - Print part "6", the tray clamp, before the tray itself to check if
//     the bushing fits.
//
// TODO:
//
//   -
//
//
// CHANGES V0.2:
//  - Y: The four clamps are now part of the tray.
//       -> Less (tiny) parts to print, better precision, no zip-ties...
// 
// CHANGES V0.2b:
//  - Y: The "floor" of the top tray part can now be set independently (yA_TrayFloorTop).
//
// CHANGES V0.2c:
//  - Y: The bars now have clamps to fix the rods and the holes go completely
//       through the bars.
//
// CHANGES V0.2d:
//  - Y: Added holes for a microswitch in the rear bar
//
// CHANGES V0.3:
//  - A: Splitted axes to own files.
//  - X: Started to work on the x axis.
//
// CHANGES V0.4:
//  - A: 2 files per axis were too much; Now only one per axis
//  - X: initial release for x-bars, rods, motor mount and belt tensioner
//  - X: fixed missing hole(s) in belt tensioner (ball bearing)
//  - X: redesigned the top X-tray part
//
// CHANGES V0.4b:
//  - A: fixed calculation of NEMA11 motors (not relevant for machine though...)
//  - X: added holes for a microswitch
//  - Y: increased the bar height by 2mm; more space for locking nut for front bar bearings
//  - A: added a workaround related to changing yA_BarHeight
//  - A: increased the clamp size by 1mm (yA_TrayClampXZ)
//  - A: increased the space for the bush bearing in the clamp a little
//  - Y: added a variable for the zip-tie channel depth in the top tray (yA_TrayFloorSlotZ)
//
// CHANGES V0.4c:
//  - X: zip-tie channels in bot tray turned off if "xA_SMZIPHOLES" (holes in servo tray) is activated
//


//=======================================================================================
//=======================================================================================
//=======================================================================================
//
// "PRINTPART" chooses, what to do:
//
//    0 -> create complete machine ("edit" mode)
//    1 -> Y tray bottom
//    2 -> Y front bar
//    3 -> Y rear bar
//    4 -> Y motor mount
//    5 -> Y tray top
//    6 -> Y tray clamp   <--- PRINT TO CHECK BUSHING SIZE ONLY. PART OF TRAY!
//   10 -> X right bar
//   11 -> X left bar
//   12 -> X belt tensioner
//   13 -> X tray bot (clamp part)
//   14 -> X tray top (servo tray)
//

PRINTPART =  0;  // choose which part should be created


//=======================================================================================
//=======================================================================================
//=======================================================================================

include <PIB_Y_Axis.scad>;
include <PIB_X_Axis.scad>;



//=======================================================================================

CP = 100; // $fn parameter for arcs



//=======================================================================================
//=======================================================================================

if( PRINTPART == 0 )
{
  ShowMachine();
}
else
{
  // ----------------------------
  if( PRINTPART == 1 )
  {
    rotate([0,180,0])
    translate([ 0, 0, -yA_TrayFloor])
    Y_TrayBot();
  }
  // ----------------------------
  else if( PRINTPART == 2 )
  {
    translate([0,0,yA_BarDepth/2])
    rotate([90,0,0])
    translate([0,0,-yA_BarOffsZ+yA_BarHeight/2])
    Y_BarFront();
  }
  // ----------------------------
  else if( PRINTPART == 3 )
  {
    translate([0,0,yA_BarDepth/2])
    rotate([-90,0,0])
    translate([0,0,-yA_BarOffsZ+yA_BarHeight/2])
    Y_BarBack();
  }
  // ----------------------------
  else if( PRINTPART == 4 )
  {
    translate([0,0,yA_MMountY/2])
    rotate([90,0,0])
    translate([0,0,yA_MMountLegZ/2])
    Y_MotBlock();
  }
  // ----------------------------
  else if( PRINTPART == 5 )
  {
     translate( [0,0,-yA_TrayFloor] )
     Y_TrayTop();
  }
  // ----------------------------
  else if( PRINTPART == 6 )
  {
    rotate([0,180,0])
    Y_TrayClamp();
  }

  // ----------------------------
  else if( PRINTPART == 10 )
  {
    rotate([0,-90,0])
    translate([ -xA_RodLen/2 + xA_BarX, 0, -zFloor - xA_BarZ/2])
    X_BarRight();
  }
  // ----------------------------
  else if( PRINTPART == 11 )
  {
    rotate([0,90,0])
    translate([ xA_RodLen/2 - xA_BarX, 0, -zFloor - xA_BarZ/2])
    X_BarLeft();
  }
  // ----------------------------
  else if( PRINTPART == 12 )
  {
    rotate([0,90,0])
    translate([ xA_RodLen/2 + xA_BarX - xA_BBClampX/2, 0,
                -zFloor - xA_RodZ - xA_RodDist/2 - xA_BeltHoleOffsZ])
    X_BeltClamp();
  }
  // ----------------------------
  else if( PRINTPART == 13 )
  {
    rotate([90,0,0])
    translate([0,+xA_TSizeY - xA_TSink + yA_trayClamXtraZ + yA_TrayClampXZ/2 ,
                - zLowRod - ( xA_RodDist + yA_TrayClampXZ )/2 + yA_TrayClampXZ/2])  
    X_Tray();
  }
  // ----------------------------
  else if( PRINTPART == 14 )
  {
    rotate([-90,0,0])
    translate([ 0, - yTrayTop ,
                 - zLowRod + ( -xA_RodDist + yA_TrayClampXZ )/2 - yA_TrayClampXZ/2 ])
    X_ServoTray();
  }
  
}


//=======================================================================================
module ShowMachine()
{

  Y_TrayBot();
  Y_TrayTop();

  translate([yA_TrayClampPos[0][0],0,0])
  Y_Rod();
  translate([-yA_TrayClampPos[0][0],0,0])
  Y_Rod();

  translate([0,yA_BarDist/2 - yA_BarDepth/2 + 0.2, 0]) // 0.2 makes rod end visible bar
  Y_BarBack();

  translate([0,-yA_BarDist/2 + yA_BarDepth/2 - 0.2, 0])// 0.2 makes rod end visible bar
  Y_BarFront();

  translate([yA_MMountPosX, yA_BarDist/2 + yA_MMountY,
             yA_MMountLegZ - yA_BarHeight + yA_BarOffsZ])
  Y_MotBlock();

  translate([yA_MMountPosX, yA_BarDist/2 + yA_MMountY,
             yA_MMountLegZ - yA_BarHeight + yA_BarOffsZ])
  translate([0,0,-20-yA_BarHeight+17.0])
  rotate([0,180,0])
  translate([0,0,-zFloor])
  Nema11();

  X_BarRight();
  
  X_BarLeft();
  
  X_Rods();
  
  X_BeltClamp();

  translate([0,0,yA_BarHeight-17.0])
  translate([0,0,20])
  translate([ xA_RodLen/2 + xA_MMountY/2, 0, 0 ])
  translate([ 0, 0, xA_MMountZPos - xA_MMountZ - (xA_MotorShaft - xA_MMountZ)/2 ])
  Nema11();
  
  X_Tray();
  
  X_ServoTray();

}


