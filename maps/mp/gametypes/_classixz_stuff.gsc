
init()
{

}

doClientDvars()
{
	self setclientdvar("r_glow", 1);
	self setclientdvar("r_glow_allowed", 1);
	self setclientdvar("r_glow_enable", 1);
	self setclientdvar("r_lightTweakSunLight", 15);
	self setclientdvar("r_lightTweakSunColor", "1 1 1");
	self setclientdvar("r_skyColorTemp", 22222);
	self setclientdvar("r_dof_bias", 0.1);
	self setclientdvar("r_dof_enable", 0);
	self setclientdvar("r_dof_tweak", 1);
	self setclientdvar("r_dof_viewModelEnd", 0);
	self setclientdvar("r_dof_nearBlur", 0);
	self setclientdvar("r_dof_nearend", 0);
	self setclientdvar("r_dof_farBlur", 0);
	self setclientdvar("r_dof_farStart", 0);
	self setclientdvar("r_dof_farEnd", 250);
	self setclientdvar("cg_gun_x", -0.65);
	self setclientdvar("r_lodBiasRigid", -1000);
	self setclientdvar("r_lodBiasSkinned", -1000);
	self setclientdvar("r_fog", 0);
}
