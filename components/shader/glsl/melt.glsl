// https://www.shadertoy.com/view/XsX3zl
#ifdef GL_ES
precision mediump float;
#endif
#define RADIANS.017453292519943295

const int zoom=40;
const float brightness=.975;
float fScale=1.25;

float cosRange(float degrees,float range,float minimum){
  return(((1.+cos(degrees*RADIANS))*.5)*range)+minimum;
}

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
  float time=iTime*1.25;
  vec2 uv=fragCoord.xy/iResolution.xy;
  vec2 p=(2.*fragCoord.xy-iResolution.xy)/max(iResolution.x,iResolution.y);
  float ct=cosRange(time*5.,3.,1.1);
  float xBoost=cosRange(time*.2,5.,5.);
  float yBoost=cosRange(time*.1,10.,5.);
  
  fScale=cosRange(time*15.5,1.25,.5);
  
  for(int i=1;i<zoom;i++){
    float _i=float(i);
    vec2 newp=p;
    newp.x+=.25/_i*sin(_i*p.y+time*cos(ct)*.5/20.+.005*_i)*fScale+xBoost;
    newp.y+=.25/_i*sin(_i*p.x+time*ct*.3/40.+.03*float(i+15))*fScale+yBoost;
    p=newp;
  }
  
  vec3 col=vec3(.5*sin(3.*p.x)+.5,.5*sin(3.*p.y)+.5,sin(p.x+p.y));
  col*=brightness;
  
  // Add border
  float vigAmt=5.;
  float vignette=(1.-vigAmt*(uv.y-.5)*(uv.y-.5))*(1.-vigAmt*(uv.x-.5)*(uv.x-.5));
  float extrusion=(col.x+col.y+col.z)/4.;
  extrusion*=1.5;
  extrusion*=vignette;
  
  fragColor=vec4(col,extrusion);
}

/** SHADERDATA
{
  "title": "70s Melt",
  "description": "Variation of Sine Puke",
  "model": "car"
}
*/
