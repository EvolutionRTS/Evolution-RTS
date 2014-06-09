/* Rockunit.h -- Rock the unit when it fire a heavy weapon with lots of recoil */

#ifndef __ROCKUNIT_H_
#define __ROCKUNIT_H_


RockUnit(anglex, anglez)
{
   turn base to x-axis anglex speed <50.000000>;
   turn base to z-axis anglez speed <50.000000>;
   wait-for-turn base around z-axis;
   wait-for-turn base around x-axis;
   turn base to z-axis <0.000000> speed <20.000000>;
   turn base to x-axis <0.000000> speed <20.000000>;
}

HitByWeapon(Func_Var_1, Func_Var_2)
{
   turn base to z-axis Func_Var_2 speed <105.000000>;
   turn base to x-axis Func_Var_1 speed <105.000000>;
   wait-for-turn base around z-axis;
   wait-for-turn base around x-axis;
   turn base to z-axis <0.000000> speed <30.000000>;
   turn base to x-axis <0.000000> speed <30.000000>;
}
#endif
