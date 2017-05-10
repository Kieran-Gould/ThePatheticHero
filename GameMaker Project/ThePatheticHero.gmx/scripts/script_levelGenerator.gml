// Level generator by Kieran Gould 2016

if !instance_exists(obj_Storage)
{
    instance_create(0,0,obj_Storage);
}
if obj_Storage.health == 0
{
    room_goto(room_death);
}

randomize();

generator_location = 0;
generator_location_history = 0;
generator_height = irandom_range(0,4); // Random start seed for vertical
generator_length = irandom_range(20,30); // Random start seed for horizontal
generator_height_history = 5;
generator_chunk = 0;
generator_worldsize = 15;

moblist[0]= obj_Rock1
moblist[1]= obj_Rock2
moblist[2]= obj_Rock3

instance_create(128, ((16-generator_height)*32)-64, obj_knight);
for (n = 0; n < generator_worldsize; n+= 1)
{
    generator_chunk += 1;
    generator_mob = irandom_range(0,2);
    if generator_chunk == generator_worldsize
    {
        generator_length = 100;
        instance_create((32*j)+((generator_location_history*32)+512), ((16-generator_height)*32), obj_Drawbridge);  
        instance_create(obj_Drawbridge.x+512,100,obj_levelChanger);      
    }
    for (j = 0; j < (generator_length); j+= 1) // Horizontal drawing
    {
        instance_create((32*j)+(generator_location_history*32), ((16-generator_height)*32), obj_LandTop);
        instance_create(((32*j)+(generator_location_history*32)), (((16-generator_height)*32)+(32)), obj_LandUnder);
        generator_location = j+generator_location_history;
    }
    if generator_mob == 0 and generator_length >= 12 and (generator_chunk > 1)
    {
        instance_create(((32*j)+(generator_location_history*32)-((generator_length*32)/2)), (((16-generator_height)*32)-64), moblist[generator_mob]);
    }
    generator_location_history = generator_location;    // Inform the program where to start generating next
    generator_location_history+=1
    j = 0;
    i = 0;
    generator_random = irandom_range(0,1);

    if generator_random = 0 // Make floor lower
    {
        generator_height = generator_height + 1;
        if generator_height >= 5    // Check if floor is too low 
        {
            generator_height = 4;
            if generator_height == generator_height_history
            {
                generator_height = 3;
            }
        }
    }
    if generator_random = 1 // Make floor higher
    {
        generator_height = generator_height - 1; // Check if floor is too high
        if generator_height <= -1
        {
            generator_height = 0;
            if generator_height == generator_height_history
            {
                generator_height = 1;
            }
        }
    }    
    generator_height_history = generator_height;    
    generator_length = irandom_range(8,14);
    //show_debug_message("Processing Chunk: " + string(generator_chunk));
    //show_debug_message("Chunk Length: " + string(generator_length));
    show_debug_message("Chunk Height: " + string(generator_height));
}
instance_create(0,0,obj_BG_1);
instance_create(0,0,obj_Fade);
instance_create(0,0,obj_Black);
