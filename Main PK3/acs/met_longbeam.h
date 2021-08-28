// I have no idea what any of this code does, sooooo
// I guess I'll just copy/paste it all in here and hope nothing breaks.

// LONG BEAM SHIT
// ==================

//int TrailItems[TRAILCOUNT]     = {"LongBeamItem", "LBChargeItem", "SuperNoclipBurstItem"};
int TrailStarts[TRAILCOUNT]    = {24, 24, 16};
int TrailDensities[TRAILCOUNT] = {24, 24, 16};
int TrailModes[PLAYERMAX];
int TempCoordsLong[PLAYERMAX][3];

script METROID_LONG_XYZ (int which, int mode)
{
    int x, y, z;
    int angle;

    /*angle = GetActorAngle(0);
    x  = GetActorX(0); y =  GetActorY(0);  z = GetActorZ(0);
    x += (12 * sin(angle));
    y -= (12 * cos(angle));*/
    x = GetActorX(0); y = GetActorY(0); z = GetActorZ(0);
    SetActivatorToTarget(0);
    int pln = PlayerNumber();

    which = condFalse(which, METROID_LONG_TRAIL);
    TrailModes[pln] = middle(0, mode, TRAILCOUNT-1);

    ACS_ExecuteAlways(which, 0, x,y,z);
    //ACS_ExecuteWithResult(469, x,y,z); // For explosive trails
}

script METROID_LONG_BURST (int tx, int ty, int tz) clientside
{
    if (ConsolePlayerNumber() == -1) { terminate; }

    int i, k = 0, l;
    int ii, p;
    int x, y, z;
    int vx, vy, vz, mag, magI;
    int angle;

    angle = GetActorAngle(0);
    x  = GetActorX(0); y =  GetActorY(0);  z = GetActorZ(0) + 25.0;
    x += (12 * sin(angle));
    y -= (12 * cos(angle));

    vx = tx-x; vy = ty-y; vz = tz-z; mag = magnitudeThree_f(vx, vy, vz);
    vx = FixedDiv(vx, mag); vy = FixedDiv(vy, mag); vz = FixedDiv(vz, mag);
    magI = ftoi(mag);

    for (i = 48; i < magI; i += 24)
    {
        Spawn("LBChargeEffect", x+(vx*i), y+(vy*i), z+(vz*i));
    }
}

script METROID_LONG_TRAIL (int tx, int ty, int tz) clientside
{
    if (ConsolePlayerNumber() == -1) { terminate; }

    int i, k = 0, l;
    int x, y, z;
    int ii, p;
    int vx, vy, vz, mag, magI;
    int angle;

    angle = GetActorAngle(0);
    x  = GetActorX(0); y =  GetActorY(0);  z = GetActorZ(0) + 25.0;
    x += (12 * sin(angle));
    y -= (12 * cos(angle));

    vx = tx-x; vy = ty-y; vz = tz-z; mag = magnitudeThree_f(vx, vy, vz);
    vx = FixedDiv(vx, mag); vy = FixedDiv(vy, mag); vz = FixedDiv(vz, mag);
    magI = ftoi(mag);

    for (i = 48; i < magI; i += 16)
    {
        Spawn("LongBeamTrail", x+(vx*i), y+(vy*i), z+(vz*i));
    }
}

script METROID_LONG_COORDSHIT (int which)
{
    int pln = PlayerNumber();
    int ret = 0;

    switch (which)
    {
        case 0: ret = TempCoordsLong[pln][0]; break;
        case 1: ret = TempCoordsLong[pln][1]; break;
        case 2: ret = TempCoordsLong[pln][2]; break;
    }

    SetResultValue(ftoi(ret));
}
