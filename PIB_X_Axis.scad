//
// PostIt-Bot, X-AXIS
//
// FMMT666(ASkr)
// www.askrprojects.net
//

//
// NOTES:
//
//   - All coordinates given (x,y,z) are valid "in-situ", with all parts assembled.
//     "x" is left/right
//     "y" if forward/backward
//     "z" is up/down
//

//
// TODO:
//
//   - Distance (x) of the tray clamps and width of the tray are independent:
//        xA_TClampDist, xA_TSizeX
//     The prism distance (x) is tied to the clamps.
//     While all of this ^^^ leaves enough "configuration headroom", it indeed
//     requires some calculations or at least, a brilliant OpenSCAD-render-preview-look ;-)
//


xA_BarX =            10.0;      // 1/3 x size of the bar (width, made of 3 pieces)
xA_BarY =            32.0;      // y size of the bar (depth)
xA_BarZ =            90.0;      // z size of the 1st, main bar (height)
xA_BarZ2 =           45.0;      // z size of the 2nd bar (height)
xA_BarHoleDia =       3.5;      // diameter of the 3 holes in the x-bar foot
xA_BarNutSize =       6.0;      // width across flats of nuts that fixes rods (cutout)
xA_BarNutThick =      3.0;      // thickness of these nuts (cutout)
xA_BarNutHole =       3.6;      // diameter of the hole for the screw

xA_RodLen =         160.0;      // length of the x-axis rod
xA_RodDist =         30.0;      // distance of the two rods
xA_RodZ =            50.0;      // z position of the lower rod
xA_RodDia =      yA_RodDia;     // diameter of the holes for the x-axis rods
xA_RodDiaHole =  yA_RodDiaHole; // diameter of the hole in the clamp
xA_BBearingDia = yA_BBearingDia;// diameter of hole for bush bearing in the clamp
xA_BBearingLen = yA_BBearingLen;// length of bush bearing

xA_MMountX =         32.0;      // width of the motor mount (x)
xA_MMountY =         32.0;      // depth of the motor mount (y) TODO: RENAME TO ...Y
xA_MMountZ =         10.0;      // height of the motor mount (z)
xA_MMountDia = yA_MMountDia;    // diameter of the inner cutout for stepper
xA_MMountDepth = yA_MMountDepth;// depth of the cutout
xA_MMountADia = yA_MMountADia;  // diameter of the axis hole
xA_MMountSDis = yA_MMountSDis;  // screw distance
xA_MMountSDia = yA_MMountSDia;  // screw hole diameter
xA_MotorShaft =      18.0;      // motor shaft length
xA_MMountZPos = xA_RodZ + xA_RodDist/2; // height (z) of the y motor mount
xA_SwHoleOffsX =      1.0;      // additional offset of the microswitch holes (x)

xA_BeltHoleY =       16.0;      // belt hole width (y)
xA_BeltHoleZ =        8.0;      // belt hole height (z)
xA_BeltHoleOffsZ =    1.0;      // additional height of the belt hole (z)

xA_BBClampX =        12.0;      // x size of belt clamp
xA_BBClampZ =        13.0;      // z size of belt clamp
xA_BBClampCutY = xA_BeltHoleY;  // space for two 10x4mm ball bearings and 2x0.5mm washer (y)
xA_BBClampCutZ =      9.0;      // space for two 10x4mm ball bearings and 2x0.5mm washer (z)
xA_BBClampSDia =      3.5;      // diameter of hole for screws
xA_BBClampSDia2 =     3.5;      // diameter of hole for ball bearing

xA_TClampDist =      33.0;      // distance of the tray clamps (x) (width is yA_TrayClampY)
xA_TSizeX =          45.0;      // width of the tray (x)
xA_TSizeY =           3.0;      // thickness of the tray (y)
xA_TSizeXtraZ =       0.0;      // extra height of the tray(z)
xA_TSink =            2.0;      // how far should the tray sink into the clamps? (y)

xA_PPosX =            6.0;      // prism position from middle of servo tray; both dirs (x)
xA_PSizeX =          12.0;      // prism width (x)
xA_PSizeY =           6.0;      // prism thickness (y)
xA_PSizeZ =          11.0;      // prism height, will be aligned to top/bot of tray (z)
xA_PCutType =         5;        // number of edges of the "prism cutter" ($fn for cylinder)
xA_PCutDepth =        5.0;      // depth of the prism cut

xA_SMZIPHOLES =         1;      // EXPERIMENTAL: make zip-tie holes in servo mount tray (1/0 = on/off)
                                //               this also turns off the zip-tie channels in the bot tray
xA_SMSCREWHOLES =       1;      // EXPERIMENTAL: make screw holes in servo mount tray (1/0 = on/off)
xA_SMScrewDia =       3.5;      // diameter of the screws in the servo mount
xA_SMScrewPosX =     16.5;      // screw hole position from middle of tray; both dirs (x)
xA_SSizeY =           2.0;      // thickness of the servo tray (y)
xA_SMPosX =          16.5;      // servo pod position from middle of servo tray; both dirs (x)
xA_SMSizeX =          9.0;      // servo mount pod width (x)
xA_SMSizeZ =          7.0;      // servo mount pod height (z)
xA_SMSizeY =         21.0;      // servo mount pod length (y), servo is on top of this
yA_SMDist =          22.6;      // space for servo body (space between pods, z)
yA_SMHoleDia =        2.0;      // diameter of holes in pod for screws
yA_SMHoleDepth =      8.0;      // depth of the holes in pod for screws


//=======================================================================================

zFloor  = -yA_BarHeight + yA_BarOffsZ;               // absolute floor height
zLowRod = zFloor + xA_RodZ;                          // absolute lower rod height
zClampHoleOffs = yA_TrayClampXZ/2+yA_trayClamXtraZ;  // absolute clamp-hole offset
yTrayTop = -xA_TSizeY + xA_TSink - yA_trayClamXtraZ - yA_TrayClampXZ/2; // dist



//=======================================================================================






//=======================================================================================
//=== PART!
module X_ServoTray()
{

  difference()
  {
  
    //--------------------------------------------------------------------------------
    union()
    {
      // four servo mount pods
      for( z = [ -yA_SMDist/2 - xA_SMSizeZ/2 , yA_SMDist/2 + xA_SMSizeZ/2 ] )
      {
        for( x = [ -xA_SMPosX, xA_SMPosX ] )
        {
          difference()
          {
            // servo mount pod
            translate([ x, yTrayTop - xA_SMSizeY/2 - xA_SSizeY, zLowRod + xA_RodDist/2 + z])
            cube([ xA_SMSizeX, xA_SMSizeY, xA_SMSizeZ ], center = true );
            
            // screw holes
            translate([x,-yA_SMHoleDepth/2 - 1 + yTrayTop - xA_SSizeY - xA_SMSizeY + yA_SMHoleDepth,
                        zLowRod + xA_RodDist/2 + z])
            rotate([90,0,0])
            cylinder( r = yA_SMHoleDia/2, h = yA_SMHoleDepth + 2, center = true, $fn = CP);
          }
        }// END for x
      }// END for z
    
    
      // four prisms
      // NEW: independent x position
      for( z = [ zLowRod , zLowRod + xA_RodDist ] )
      {
        for( x = [ -xA_PPosX, xA_PPosX ] )
        {
          // prism
          translate([ x, -xA_PSizeY/2 + yTrayTop - xA_SSizeY, z])
          X_TrayPrism();
        }
      }
      
      // servo tray plate
      translate([ 0, yTrayTop - xA_SSizeY/2,
                  zLowRod + ( xA_RodDist + yA_TrayClampXZ )/2 - yA_TrayClampXZ/2 ])
      rotate([90,0,0])
      cube( [xA_TSizeX, xA_RodDist + yA_TrayClampXZ + xA_TSizeXtraZ, xA_SSizeY ], center = true );
      
    }// END union
    //--------------------------------------------------------------------------------

    // holes for screws
    if( xA_SMSCREWHOLES )
      X_TrayHoles();
    
    // holes for zip-ties
    if( xA_SMZIPHOLES )
    {
      // make four zip tie-cutouts (also works if tray is larger than clamp distance)
      for( z = [ zLowRod , zLowRod + xA_RodDist ] )
      {
        for( x = [ -xA_TClampDist/2 , xA_TClampDist/2 ] )
        {
          // upper zip-tie cutouts
          translate([x,0,z + yA_TrayClampXZ/2 + zipTieHeight/2 + 0.2])
          cube([ zipTieWidth, 20*xA_TSizeY, zipTieHeight ], center = true );
          
          // lower zip-tie cutouts
          translate([x,0,z - yA_TrayClampXZ/2 - zipTieHeight/2 - 0.2])
          cube([ zipTieWidth, 20*xA_TSizeY, zipTieHeight ], center = true );

          // two zip tie channels
          translate([0, -xA_SSizeY - zipTieHeight/2, 0])
          translate( [x, - yA_TrayClampXZ/2 - yA_trayClamXtraZ - xA_TSizeY + xA_TSink ,0] )
          rotate( [90,0,0] )
          cube([ zipTieWidth, 10*xA_RodDist, zipTieHeight ], center = true );
        
        }// END for x
      }// END for z
    }// END if xA_SMZIPHOLES
  
  }// END difference
 
  
}


//=======================================================================================
module X_TrayHoles()
{
  for( x = [ -xA_SMScrewPosX, xA_SMScrewPosX ] )
  {
    translate([x, 0, zLowRod + xA_RodDist/2 ])
    rotate([90,0,0])
    cylinder( r = xA_SMScrewDia/2, h = 500, center = true, $fn = CP );
  }
}


//=======================================================================================
module X_TrayPrism()
{
  difference()
  {
    // the prism block
    cube( [xA_PSizeX, xA_PSizeY, xA_PSizeZ], center = true );
    
    // the cutout
    translate([0, -xA_PSizeY/2 + xA_PCutDepth,0])
    rotate([0,0,90])
    translate([-xA_PSizeX,0,-xA_PSizeZ])
    cylinder( r = xA_PSizeX, h = 2*xA_PSizeZ, $fn = xA_PCutType);
  }
}


//=======================================================================================
//=== PART!
module X_Tray()
{
  difference()
  {
    // x tray and four clamps
    union()
    {
      translate([ 0, -xA_TSizeY/2 + xA_TSink - yA_trayClamXtraZ - yA_TrayClampXZ/2,
                  zLowRod + ( xA_RodDist + yA_TrayClampXZ )/2 - yA_TrayClampXZ/2 ])
      rotate([90,0,0])
      cube( [xA_TSizeX, xA_RodDist + yA_TrayClampXZ + xA_TSizeXtraZ, xA_TSizeY ], center = true );

      X_TrayClamps();
    }// END union

    // make four zip tie-cutouts (also works if tray is larger than clamp distance)
    for( z = [ zLowRod , zLowRod + xA_RodDist ] )
    {
      for( x = [ -xA_TClampDist/2 , xA_TClampDist/2 ] )
      {
        // upper zip-tie cutouts
        translate([x,0,z + yA_TrayClampXZ/2 + zipTieHeight/2 + 0.2])
        cube([ zipTieWidth, 20*xA_TSizeY, zipTieHeight ], center = true );
        
        // lower zip-tie cutouts
        translate([x,0,z - yA_TrayClampXZ/2 - zipTieHeight/2 - 0.2])
        cube([ zipTieWidth, 20*xA_TSizeY, zipTieHeight ], center = true );

        if( !xA_SMZIPHOLES )
        {
          // two zip tie channels
          translate( [x, - yA_TrayClampXZ/2 - yA_trayClamXtraZ - xA_TSizeY + xA_TSink ,0] )
          rotate( [90,0,0] )
          cube([ zipTieWidth, 10*xA_RodDist, 2*zipTieHeight ], center = true );
        }
      
      }// END for x
    }// END for z

    // holes for screws
    if( xA_SMSCREWHOLES )
      X_TrayHoles();

  }// END difference

}


//=======================================================================================
module X_TrayClamps()
{
  for( z = [ zLowRod , zLowRod + xA_RodDist ] )
  {
    for( x = [ -xA_TClampDist/2 , xA_TClampDist/2 ] )
    {
      translate([x,0,z])
      rotate([0,-90,90])
      translate([ 0, 0, zClampHoleOffs ])
      Y_TrayClamp();
    }// END for x
  }// END for z
}


//=======================================================================================
module NutSlot( width, thickness, length, along_y )
{
  hull()
  {
    Nut( width, thickness );
    if( along_y )
    {
      translate([ 0, length, 0] )
      Nut( width, thickness );
    }
    else
    {
      translate([ length, 0, 0] )
      Nut( width, thickness );
    }
  }
}


//=======================================================================================
module Nut( width, thickness )
{
  intersection()
  {
    rotate([0,0,120])
    cube([ 3*width, width, thickness ], center=true);
    rotate([0,0,60])
    cube([ 3*width, width, thickness ], center=true);
    cube([ 3*width, width, thickness ], center=true);
  }
}


//=======================================================================================
module NutSlotCutsXBars()
{
  // needs to be moved right by "xA_RodLen/2 - xA_BarX/2"

  // lower nut slots
  translate([ 0, xA_BarY/4, xA_RodZ + zFloor ])
  rotate([90,0,180])
  NutSlot( xA_BarNutSize, xA_BarNutThick, 10*xA_BarNutSize, 0 );
  translate([ 0, -xA_BarY/4, xA_RodZ + zFloor ])
  rotate([90,0,180])
  NutSlot( xA_BarNutSize, xA_BarNutThick, 10*xA_BarNutSize, 0 );

  // upper nut slots
  translate([ 0, xA_BarY/4, xA_RodZ + zFloor + xA_RodDist])
  rotate([90,0,180])
  NutSlot( xA_BarNutSize, xA_BarNutThick, 10*xA_BarNutSize, 0 );
  translate([ 0, -xA_BarY/4, xA_RodZ + zFloor + xA_RodDist])
  rotate([90,0,180])
  NutSlot( xA_BarNutSize, xA_BarNutThick, 10*xA_BarNutSize, 0 );

  // lower hole for rod fixing screw
  translate([ 0, 0, xA_RodZ + zFloor])
  rotate([90,0,0])
  cylinder( r = xA_BarNutHole/2, h = xA_BarY+2, center = true, $fn = CP);

  // upper hole for rod fixing screw
  translate([ 0, 0, xA_RodZ + zFloor + xA_RodDist])
  rotate([90,0,0])
  cylinder( r = xA_BarNutHole/2, h = xA_BarY+2, center = true, $fn = CP);
  
}



//=======================================================================================
//=== PART!
module X_BeltClamp()
{

  translate([ -xA_RodLen/2 -  xA_BarX, 0, 0])

  difference()
  {
    translate([ 0, 0, zFloor + xA_RodZ + xA_RodDist/2 + xA_BeltHoleOffsZ])
    cube([ xA_BBClampX, xA_BarY, xA_BBClampZ ], center=true);

    translate([ 0, 0, zFloor + xA_RodZ + xA_RodDist/2 + xA_BeltHoleOffsZ])
    cube([ xA_BBClampX + 2, xA_BBClampCutY, xA_BBClampCutZ ], center=true);
    
    translate([ 0, 0, zFloor + xA_RodZ + xA_RodDist/2 + xA_BeltHoleOffsZ])
    cylinder( r = xA_BBClampSDia2 / 2, h = xA_BBClampZ + 2, center = true, $fn = CP);
    
//    xA_BBClampSDia2
    
    X_ClampHoles();
  }
  
}


//=======================================================================================
module X_ClampHoles()
{
  translate([ xA_RodLen/2, xA_BarY/2 - (xA_BarY - xA_BBClampCutY)/4, 0 ])
  translate([ 0, 0, zFloor + xA_RodZ + xA_RodDist/2 + xA_BeltHoleOffsZ])
  rotate([0,-90,0])
  cylinder( r = xA_BBClampSDia/2, h = xA_RodLen, center = false, $fn = CP);
  
  translate([ xA_RodLen/2, - xA_BarY/2 + (xA_BarY - xA_BBClampCutY)/4, 0 ])
  translate([ 0, 0, zFloor + xA_RodZ + xA_RodDist/2 + xA_BeltHoleOffsZ])
  rotate([0,-90,0])
  cylinder( r = xA_BBClampSDia/2, h = xA_RodLen, center = false, $fn = CP);

}

//=======================================================================================
module X_MotBlock()
{
  // POSITION: bottom of the block at [ 0, 0, zFloor ]
  
  translate([0,0,zFloor])
  rotate([180,0,0])
  difference()
  {
    // motor mounting block
    translate([ 0, 0, -xA_MMountZ/2 ])
    cube([ xA_MMountX, xA_MMountY, xA_MMountZ], center=true);

    // round motor mount cutout
    translate([ 0, 0, -xA_MMountDepth ])
    cylinder( r = xA_MMountDia/2, h = xA_MMountDepth + 1, center = false, $fn = CP);
    
    // motor axis cutout
    translate([ 0, 0, -xA_MMountZ/2 ])
    cylinder( r = xA_MMountADia/2, h = xA_MMountZ+2, center = true, $fn = CP);

    // screw cutouts
    for( i = [0 : 90 : 270] )
    {
      rotate([0,0,i])
      translate([ xA_MMountSDis/2, xA_MMountSDis/2, -xA_MMountZ/2 ])
      cylinder( r = xA_MMountSDia/2, h = xA_MMountZ+2, center = true, $fn = CP);
    }
    
  }// END difference
}



//=======================================================================================
module Nema11( )
{
  // POSITION: tip of shaft at [ 0, 0, zFloor ]
  // length of shaft is 18mm, thickness of round "plate" is 2mm
  
  translate([ 0,0, 2*zFloor - 45/2])
  union()
  {
    translate([ 0, 0, 45/2 + 1 + 18/2])
    cylinder( r = 2.5, h = 18, center = true, $fn = CP);
    translate([0,0,45/2 + 1])
    cylinder( r = 11, h = 2, center = true, $fn = CP);
    cube([28,28,45], center=true);
  }
}


//=======================================================================================
module X_Rods( )
{
  // upper rod
  translate([ 0, 0, xA_RodZ + xA_RodDist + zFloor ])
  rotate([0,90,0])
  cylinder( r = xA_RodDia/2, h = xA_RodLen, center = true, $fn = CP);
  
  // lower rod
  translate([ 0, 0, xA_RodZ + zFloor ])
  rotate([0,90,0])
  cylinder( r = xA_RodDia/2, h = xA_RodLen, center = true, $fn = CP);
}


//=======================================================================================
module X_BeltHoleCutout( )
{
  translate([ 0, 0, zFloor + xA_RodZ + xA_RodDist/2 + xA_BeltHoleOffsZ])
  cube([xA_RodLen + 3 * xA_BarX, xA_BeltHoleY, xA_BeltHoleZ ], center=true);
}


//=======================================================================================
module X_MicroswitchHoles( )
{
  // POS: directly where they should be

  translate([ xA_SwHoleOffsX, 0, 0] )
  translate([ 0,0, xA_RodZ + 1/2*xA_RodDist] )
  translate([ 0, -xA_BarY/2, 0 ])  // y pos right now
  translate([ -xA_BarX/2, 0, 0])   // x middle of right bar
  translate([ xA_RodLen/2 ,0 ,0 ]) // x at end of rod (right)
  translate([ 0,0,zFloor])         // z at zFloor now
  rotate([0,90,-90])
  Y_SwHoles  ();
}


//=======================================================================================
//=== PART!
module X_BarRight( )
{
  difference()
  {
    union()
    {
      translate([ xA_RodLen/2 + xA_MMountY/2, 0, 0 ])
      translate([ 0, 0, xA_MMountZPos - xA_MMountZ - (xA_MotorShaft - xA_MMountZ)/2 ])
      X_MotBlock();
      
      translate([ xA_RodLen/2 - xA_BarX, 0, 0 ])
      X_Bar();
      
    }
    
    // hole for belt
    X_BeltHoleCutout();

    // holes for rods
    translate([1,0,0])
    X_Rods();

    // holes for nuts (to fix rods)
    translate([ xA_RodLen/2 - xA_BarX/2, 0, 0])
    NutSlotCutsXBars();
    
    // holes for the microswitch
    X_MicroswitchHoles();
    
  }// END difference

}


//=======================================================================================
//=== PART!
module X_BarLeft( )
{
  difference()
  {
    translate([ -xA_RodLen/2 + xA_BarX, 0, 0 ])
    rotate([0,0,180])
    X_Bar( 1 );

    X_BeltHoleCutout();
    
    X_ClampHoles();

    translate([-1,0,0])
    X_Rods();
    
    // holes for nuts (to fix rods)
    translate([ -xA_RodLen/2 + xA_BarX/2, 0, 0])
    rotate([0,0,180])
    NutSlotCutsXBars();
  }
}


//=======================================================================================
module X_Bar( bigX )
{
  difference()
  {
    union()
    {
      // 1st bar (large y)
      translate([ xA_BarX/2, 0,xA_BarZ/2 + zFloor ])
      cube([xA_BarX, xA_BarY, xA_BarZ ], center=true);

      if( bigX )
      {      
        // 2nd bar (small y)
        translate([1.5*xA_BarX,0,xA_BarZ2/2 + zFloor ])
        cube([xA_BarX, xA_BarY/3, xA_BarZ2 ], center=true);
        
        // outer foot      
        translate([2.5*xA_BarX,0,xA_BarX/2 + zFloor ])
        cube([xA_BarX, xA_BarY/3, xA_BarX ], center=true);
      }

      // front and rear foot
      translate([xA_BarX/2,0,xA_BarX/2 + zFloor ])
      cube([xA_BarX, 5*xA_BarY/3, xA_BarX ], center=true);
    }

     // front hole
     translate([ xA_BarX/2, -4*xA_BarY/6, xA_BarX/2 + zFloor ])    
     cylinder( r = xA_BarHoleDia/2, h = xA_BarX + 2, center = true, $fn = CP);

     // rear hole
     translate([ xA_BarX/2, +4*xA_BarY/6, xA_BarX/2 + zFloor ])    
     cylinder( r = xA_BarHoleDia/2, h = xA_BarX + 2, center = true, $fn = CP);
 
     // outer hole 
     translate([ 2.5*xA_BarX, 0, xA_BarX/2 + zFloor ])    
     cylinder( r = xA_BarHoleDia/2, h = xA_BarX + 2, center = true, $fn = CP);
  }
}
