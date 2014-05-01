//
// PostIt-Bot, Y-AXIS
//
// FMMT666(ASkr)
// www.askrprojects.net
//

//
// - MOTOR MOUNT POSITION
//   The parameter "yA_MMountPosX" specifies the lateral (x) position of the
//   motor mount and the holes in the rear (back) bar.
//   Remember to check or adapt:
//     - "pX"             -> x position of the clamps (and rods)
//     - "yA_BBClampXPos" -> x position of the belt ball bearing
//     - "yA_TrayHOffsX"  -> x position of the belt mounting hole in the tray
//
// - Rod height (z position) is determined by the length of the rods.
//   ??? what?
//


postItX =            77.0;      // VIEW ONLY
postItY =            77.0;
postItZ =            10.0;

yA_TrayWall =         2.0;      // wall thickness of PostIt tray
yA_TrayZ =            3.0;      // wall height of PostIt Tray
yA_TrayFloor =        3.0;      // height of PostIt tray floor (bottom part)
yA_TrayFloorTop =     4.5;      // height of PostIt tray floor (top part)
yA_TrayFloorSlotZ =   2.1;      // depth of the zip-tie "channels" in the top tray

yA_TrayClampXZ =     12.0;      // x and z size of clamp
yA_TrayClampY =      12.0;      // y size of clamp
yA_trayClamXtraZ =    3.0;      // extra length of the clamp
yA_TrayZTOffsX =      1.0;      // lateral X offset of zip tie holes
yA_TrayHDia =         3.5;      // diameter of the middle hole
yA_TrayHDiaB =        6.0;      // diameter of the middle, blind hole (screw head)
yA_TrayHDiaBDepth =   2.3;      // depth of the middle, blind hole
yA_TrayHOffsX =       5.0;      // x offset of the hole "in the middle"

yA_RodDia =           4.4;      // diameter of the holes in the bars for the y-axis rods

yA_RodDiaHole =       6.3;      // diameter of the two holes in the clamp (rod in/out)
yA_BBearingLen =      4.6;      // length of bush bearing
yA_BBearingDia =      7.8;      // diameter of the hole for the bush bearing in the clamp

yA_BarHeight =       19.0;      // height of the rod holding bars (z) infl. motor mount and zFloor
yA_BarDepth =        10.0;      // depth of the rod holding bars (y)
yA_BarWidth =        80.0;      // width of the bars (x)

yA_BarDist =        180.0;      // distance of the two bars (inner to inner)

yA_BarOffsZ =        -2.0;      // additional z position offset ( <0 means down)
yA_BarMHDia =         4.0;      // mounting hole diameter
yA_BarMHOffsX =       5.0;      // mounting hole offset from end(!) of bar (x)
yA_BarSlotZ =         3.0;      // width of the slot in the bar

yA_BBClampX =        12.0;      // ball bearing clamp width  (x)
yA_BBClampY =        14.0;      // ball bearing clamp length (y)
yA_BBClampXPos =      0.0;      // ball bearing x position offset (from mid)
yA_BBClampCut =       9.0;      // space for two 10x4mm ball bearings and 2x0.5mm washer
yA_BBClampWall =      3.0;      // thickness of wall
yA_BBClampHole =      3.5;      // diameter of the hole
yA_BeltHoleX =       18.0;      // belt hole width (x)
yA_BeltHoleZ =        5.0;      // belt hole height (z)

yA_MMountX =         30.0;      // width of the motor mount (x) ( >= next parameter!)
yA_MMountPosX =       0.0;      // x position of the motor mount
yA_MMountY =         32.0;      // depth of the motor mount (y)
yA_MMountDia =       22.5;      // diameter of the inner cutout for stepper
yA_MMountDepth =      2.0;      // depth of the cutout
yA_MMountZ =          7.0;      // height of the motor mount (z)
yA_MMountSDis =      23.0;      // screw distance
yA_MMountSDia =       2.8;      // screw hole diameter
yA_MMountADia =       7.0;      // diameter of the axis hole
yA_MMountLegX =      10.0;      // width of a motor mount leg
yA_MMountLegZ =      25.0 - 17.0 + yA_BarHeight; // height of a motor mount leg (consider motor axis!)
yA_MMountLegDia =     4.6;      // diameter of the hole in the motor mount leg
yA_MMountLegDiaZ =   10.0;      // height of the leg hole (from BOTTOM!)

yA_SwHoleDia =        2.5;      // diameter of the holes for the microswitch
yA_SwHoleDis =       10.0;      // distance of the holes for the microswitch
yA_SwHoleDepth =      6.0;      // depth of the holes for the microswitch
yA_SwPosOffsX =       0.0;      // x offset position from rear bar middle 
yA_SwPosOffsY =       2.0;      // y offset position from rear bar middle

zipTieWidth =         4.0;      // width of the zip tie
zipTieHeight =        1.6;      // height of the zip tie

// x and y position of the rod (and tray clamps)
pX = (postItX + 2 * yA_TrayWall) / 3;
pY = ( (postItY + 2 * yA_TrayWall) / 2 ) - yA_TrayClampXZ/2 - yA_BarDepth;
yA_TrayClampPos = [ [ pX,-pY,  0 ], 
                    [-pX,-pY,  0 ],
                    [ pX, pY,  0 ],
                    [-pX, pY,  0 ] ]; // keep the complete array symmetric!

//=======================================================================================



//=======================================================================================
//=== PART!
module Y_MotBlock()
{
  // POS: top at [0,0,0]

  union()
  {
    difference()
    {
      // motor mounting block
      translate([0,0,-yA_MMountZ/2 ])
      cube([yA_MMountX,yA_MMountY,yA_MMountZ], center=true);

      // round motor mount cutout
      translate([0,0,-yA_MMountDepth])
      cylinder( r=yA_MMountDia/2, h = yA_MMountDepth+1, center = false, $fn = CP);

      // motor axis cutout
      translate([0,0,-yA_MMountZ/2])
      cylinder( r=yA_MMountADia/2, h = yA_MMountZ+2, center = true, $fn = CP);

      // screw cutouts
      for( i = [0 : 90 : 270] )
      {
        rotate([0,0,i])
        translate([yA_MMountSDis/2,yA_MMountSDis/2,-yA_MMountZ/2])
        cylinder( r=yA_MMountSDia/2, h = yA_MMountZ+2, center = true, $fn = CP);
      }
    }// END difference

    // motor mount legs
    for( i = [-1 , 1] )
    {
      difference()
      {
        translate([i * ( yA_MMountX / 2 + yA_MMountLegX / 2 ), 0 ,-yA_MMountLegZ/2 ])
        cube([yA_MMountLegX,yA_MMountY,yA_MMountLegZ], center=true);

        // motor mount legs holes
        translate([i * ( yA_MMountX / 2 + yA_MMountLegX / 2 ), 0 ,
                   -yA_MMountLegZ +yA_MMountLegDiaZ ])
        rotate([90,0,0])
        cylinder( r=yA_MMountLegDia/2, h = yA_MMountY+2, center = true, $fn = CP);
      }
    }// END for
  }// END union
}


//=======================================================================================
//=== PART!
module Y_BarBack()
{
  difference()
  {
    Y_Bar();

    // holes for rods
    translate([ pX, 0, 0 ])
    Y_Rod();
    translate([ -pX, 0, 0])
    Y_Rod();

    // slots
    translate([ -pX - yA_BarWidth/2, 0, 0 ])
    Y_BarSlotCutout();
    translate([ pX + yA_BarWidth/2, 0, 0 ])
    Y_BarSlotCutout();

    // holes for microswitch
    translate([ yA_SwPosOffsX, yA_SwPosOffsY, yA_BarOffsZ])
    Y_SwHoles();

    // belt cutout
    translate( [yA_BBClampXPos, 0, yA_BarOffsZ-yA_BBClampWall-yA_BBClampCut/2] )
    cube([yA_BeltHoleX, yA_BarDepth+2, yA_BeltHoleZ], center=true);

    // motor mount legs
    for( i = [-1 , 1] )
    {
      // motor mount legs holes
      translate([yA_MMountPosX + i * ( yA_MMountX / 2 + yA_MMountLegX / 2 ), 0 ,
                 - yA_MMountLegZ + yA_MMountLegDiaZ
                 + yA_MMountLegZ - yA_BarHeight + yA_BarOffsZ])
      rotate([90,0,0])
      cylinder( r=yA_MMountLegDia/2, h = yA_MMountY+2, center = true, $fn = CP);
    }// END for

  }// END difference
}


//=======================================================================================
module Y_SwHoles()
{
  // POS: middle between holes at [0,0]; holes go DOWN, add. height: 2mm top

  translate([ -yA_SwHoleDis/2, 0, -yA_SwHoleDepth/2 + 1 ])
  cylinder( r = yA_SwHoleDia/2, h = yA_SwHoleDepth + 2, center = true, $fn = CP);
  translate([  yA_SwHoleDis/2, 0, -yA_SwHoleDepth/2 + 1])
  cylinder( r = yA_SwHoleDia/2, h = yA_SwHoleDepth + 2, center = true, $fn = CP);
}


//=======================================================================================
//=== PART!
module Y_BarFront()
{
  difference()
  {
    union()
    {
      translate([ yA_BBClampXPos, yA_BBClampY / 2 + yA_BarDepth / 2,
                 -0.5 * ( yA_BBClampCut +2 * yA_BBClampWall ) + yA_BarOffsZ] )
      Y_BallBearClamp( );
      Y_Bar();
    }// END union

    // holes for rods
    translate([ pX, 0 ,0  ])
    Y_Rod();
    translate([ -pX, 0, 0 ])
    Y_Rod();

    // slots
    translate([ -pX - yA_BarWidth/2, 0, 0 ])
    Y_BarSlotCutout();
    translate([ pX + yA_BarWidth/2, 0, 0 ])
    Y_BarSlotCutout();

  }// END difference
}


//=======================================================================================
module Y_BarSlotCutout()
{
  translate( [ 0, 0, -yA_TrayClampXZ / 2 - yA_trayClamXtraZ ] )
  cube([ yA_BarWidth, yA_BarDepth + 2, yA_BarSlotZ], center = true );
}


//=======================================================================================
module Y_BallBearClamp( )
{
  difference()
  {
    cube([yA_BBClampX, yA_BBClampY, yA_BBClampCut+2*yA_BBClampWall], center=true);
    cube([yA_BBClampX+2, yA_BBClampY+2, yA_BBClampCut], center=true);
    cylinder(r=yA_BBClampHole/2,h=yA_BBClampCut+2*yA_BBClampWall+2,center=true,$fn=CP );
  }
}


//=======================================================================================
module Y_Rod( )
{
  translate( [ 0, 0, -yA_TrayClampXZ / 2 - yA_trayClamXtraZ ] )
  rotate( [90,0,0] )
  cylinder( r=yA_RodDia/2, h = yA_BarDist, center = true, $fn = CP);
}


//=======================================================================================
module Y_Bar( )
{
  translate([0,0,-yA_BarHeight/2 + yA_BarOffsZ])

  difference()
  {
    cube([yA_BarWidth, yA_BarDepth, yA_BarHeight], center=true);

    // right mounting hole
    translate([yA_BarWidth/2 - yA_BarMHOffsX,0,0])
    cylinder( r=yA_BarMHDia/2, h = yA_BarHeight+2, center = true, $fn = CP);

    // left mounting hole
    translate([- yA_BarWidth/2 + yA_BarMHOffsX,0,0])
    cylinder( r=yA_BarMHDia/2, h = yA_BarHeight+2, center = true, $fn = CP);
  }
}


//=======================================================================================
module Y_TrayClamp( )
{
  difference()
  {
    union()
    {
      // upper, rectangular part
      translate( [ 0, 0,-yA_TrayClampXZ/4-yA_trayClamXtraZ/2] )
      cube( [yA_TrayClampXZ, yA_TrayClampY, yA_TrayClampXZ / 2 + yA_trayClamXtraZ ],
            center = true );

      // lower, cylindrical part
      translate( [ 0, 0,-yA_TrayClampXZ/2-yA_trayClamXtraZ] )
      rotate( [90,0,0] )
      cylinder( r=yA_TrayClampXZ/2, h = yA_TrayClampY, center = true, $fn = CP);
    }//END union

    // hole for rod (3/4 rad extra)
    translate([0,0,-yA_TrayClampXZ/2-yA_trayClamXtraZ])
    rotate( [90,0,0] )
    cylinder( r = yA_RodDiaHole/2, h = 2*yA_TrayClampY, center = true, $fn = CP);

    // space for bush bearing (inside)
    translate([0,0,-yA_TrayClampXZ/2-yA_trayClamXtraZ])
    rotate([90,0,0])
    cylinder( r=yA_BBearingDia/2, h=yA_BBearingLen, center = true, $fn=CP);

    // TEST 1:
    // may be this cutout is all we need to fix the clamp AND the bushing
    translate( [ 0, 0, -yA_TrayClampXZ/2-yA_TrayClampXZ/2-yA_trayClamXtraZ ] )
    cube( [ yA_TrayClampXZ + 2, yA_BBearingLen, yA_TrayClampXZ ], center = true );

  }// END difference

}


//=======================================================================================
module PostIt_Block()
{
  translate([0,0,postItZ/2])
  cube( [ postItX, postItY, postItZ ], center = true);
}


//=======================================================================================
//=== PART!
module Y_TrayBot()
{
  difference()
  {
    union()
    {
      // the bare tray
      translate( [ 0, 0, yA_TrayFloor ] )
      translate( [ 0, 0, yA_TrayFloor/2 - yA_TrayFloor] )
      cube([ postItX + 2 * yA_TrayWall, postItY + 2 * yA_TrayWall, yA_TrayFloor ],
             center=true);

      // the new clamps (attached to the tray as of V0.2)
      for( i = yA_TrayClampPos )
      {
        translate(i)
        Y_TrayClamp();
      }
    }// END union



    for( i = yA_TrayClampPos )
    {
      // right hole for zip tie
      translate([ i[0] + yA_TrayClampXZ / 2 + yA_TrayZTOffsX, i[1], 0] )
      cube([zipTieHeight,zipTieWidth,4*yA_TrayFloor], center = true);

      // left hole for zip tie
      translate([ i[0] - yA_TrayClampXZ / 2 - yA_TrayZTOffsX, i[1], 0] )
      cube([zipTieHeight,zipTieWidth,4*yA_TrayFloor], center = true);

      // hole in the middle
      translate([yA_TrayHOffsX,0,0])
      cylinder( r = yA_TrayHDia/2, h = 3*yA_TrayFloor, center = true, $fn = CP);

    }// END for

  }// END difference

}


//=======================================================================================
//=== PART!
module Y_TrayTop()
{
  translate([0,0,yA_TrayFloor])

  difference()
  {

    translate( [0,0,yA_TrayFloorTop] )
    difference()
    {
      translate( [ 0, 0, yA_TrayZ/2 + yA_TrayFloorTop/2 - yA_TrayFloorTop] )
      cube([postItX+2*yA_TrayWall,postItY+2*yA_TrayWall,yA_TrayZ+yA_TrayFloorTop],
            center=true);
 
      PostIt_Block();
    }// END difference

    
    for( i = yA_TrayClampPos )
    {
      // top zip-tie channel
/*      
      translate([ i[0], i[1], yA_TrayFloorTop + (zipTieHeight+2)/2 - zipTieHeight] )
      cube([yA_TrayClampXZ + 2*yA_TrayZTOffsX, zipTieWidth, zipTieHeight+2 ],
           center=true);
*/
      translate([ i[0], i[1], yA_TrayFloorTop + (yA_TrayFloorSlotZ+2)/2 - yA_TrayFloorSlotZ ] )
      cube([yA_TrayClampXZ + 2*yA_TrayZTOffsX, zipTieWidth, yA_TrayFloorSlotZ+2 ],
           center=true);
           
           
      // right hole for zip tie
      translate([ i[0] + yA_TrayClampXZ / 2 + yA_TrayZTOffsX, i[1], 0] )
      cube([zipTieHeight,zipTieWidth,4*yA_TrayFloorTop], center = true);

      // left hole for zip tie
      translate([ i[0] - yA_TrayClampXZ / 2 - yA_TrayZTOffsX, i[1], 0] )
      cube([zipTieHeight,zipTieWidth,4*yA_TrayFloorTop], center = true);

      // hole in the middle
      translate([yA_TrayHOffsX,0,0])
      cylinder( r = yA_TrayHDia/2, h = 3*yA_TrayFloorTop, center = true, $fn = CP);

      // blind hole in the middle (screw head)
      translate([yA_TrayHOffsX,0,yA_TrayFloorTop - yA_TrayHDiaBDepth])
      cylinder( r = yA_TrayHDiaB/2, h = yA_TrayHDiaBDepth+1, center = false, $fn = CP);

    }// END for

  }// END difference
}
                    