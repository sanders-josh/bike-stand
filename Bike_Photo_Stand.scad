//Bike_Photo_Stand
//Made by Josh and Crystal Sanders <3
//07/04/23
//Print in SemiFlex material so that we can use the mold for epoxy. 

//Units are in mm


//45mm diameter for bike connection
//300mm long arm (roughly)
//280mm straight from the ground
//120 -180mm from the right angle

//Set up the variables

height_stand = 280;
stopper_distance_from_bike = 180;
radius_stopper = 18;
width_stand = 75;
radius_cutout = 22.5;
depth_base = 12;
depth_cutout = 18;

$fn=60;

module angled_stand ()
{
    // This module makes the part that touches the ground at an angle to hold the bike in position.
    difference()
    {
        hull()
        {
            //top of stand
            translate([0,0,height_stand-(depth_base*1.25)])
            {
                cube([1,width_stand,depth_base]);
            }
            
            //bottom of top half
            translate([stopper_distance_from_bike - 20,0,depth_base/4])
            {
                cube([depth_base, width_stand, depth_base]);
            }
        }
        
        bike_clip();
    }
    
}

module floor_stopper()
{
    // This module makes the part that lays against the ground and provides friction to keep the angled_stand from sliding away from the bike.    
    difference()
    {
        //round base
        rotate([90, 0, 0])
        {
            translate([stopper_distance_from_bike-15, 0, -width_stand/2])
            {
                cylinder(width_stand*1, radius_stopper, radius_stopper, center = true);
            }
        }
           
        //--flat bottom
        rotate([90, 0, 0])
        {
            translate([stopper_distance_from_bike-radius_stopper-9, -radius_stopper-10, -width_stand])
            {
                cube([depth_base*2, depth_base, width_stand]);
            }
        }
        
        //--insert for angled_stand
        bottom_half();
    }  
}

module bike_clip()
{
    // This module makes the part that holds the bottom bracket.  
    translate([depth_cutout,width_stand/2, height_stand - radius_cutout])
    {
        hull()
        {
            translate([0, 0, radius_cutout*1.5])
            {
                cube([2*depth_cutout, 2.5*radius_cutout, depth_cutout/4], center= true);
            }
            
            rotate([0,90,0])
            {
                cylinder(h = 4*depth_cutout, r = radius_cutout, center= true);
            }
        }
    }
}

module top_half()
{
    difference()
    {
        angled_stand();
        cube([1.5*stopper_distance_from_bike, width_stand, height_stand/2]);
    }
    
    connecting_pins();
}

module connecting_pins()
{
    pin_height = 40;
    pin_radius_ratio = 0.4;
    pin_angle = -32;
    pin_x = stopper_distance_from_bike*.6 - depth_base;
    pin_z = (height_stand-pin_height)/2;
    
    //middle pin
    translate([pin_x, width_stand/2, pin_z])
    {
        rotate([0, pin_angle, 0])
        {
            cylinder(pin_height, depth_base*pin_radius_ratio, depth_base*pin_radius_ratio);
        }
    }
    
    //left pin
    translate([pin_x, width_stand*0.1, pin_z])
    {
        rotate([0, pin_angle, 0])
        {
            cylinder(pin_height, depth_base*pin_radius_ratio, depth_base*pin_radius_ratio);
        }
    }
    
    //right pin
    translate([pin_x, width_stand*0.9, pin_z])
    {
        rotate([0, pin_angle, 0])
        {
            cylinder(pin_height, depth_base*pin_radius_ratio, depth_base*pin_radius_ratio);
        }
    }
}

module bottom_half()
{
    difference()
    {
        angled_stand();
        
        //--top half
        translate([0,0,height_stand/2])
        {
            cube([1.5*stopper_distance_from_bike, width_stand, height_stand]);
        }
        
        //--connecting pins
        connecting_pins();
       
       //--rear slantent edge
       translate([stopper_distance_from_bike-radius_stopper*1.9, 0, 0])
       {
           cube([depth_base, width_stand, depth_base]);
       }
    }
}

//bike_clip();
//top_half();
//connecting_pins();
bottom_half();
//angled_stand();
//floor_stopper();