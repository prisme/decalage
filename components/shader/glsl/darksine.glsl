float iso(vec2 v)
{
  v.y+=.001;
  v.x+=sin(v.y*20.+iTime*.1)*.2;
  return length(v)-.4;
}

vec2 grad(vec2 v)
{
  float E=.00000002*exp(1.25*sin(iTime*3.));
  float c=iso(v);
  float x=iso(v+vec2(E,0))-iso(v-vec2(E,0));
  float y=iso(v+vec2(0,E))-iso(v-vec2(0,E));
  return vec2(x,y)/E;
}

float dist(vec2 v)
{
  float i=iso(v);
  vec2 g=grad(v);
  return abs(i)/length(g);
}

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
  vec2 uv=(fragCoord.xy-iResolution.xy*.5)/iResolution.y;
  float d=dist(uv);
  vec3 color=mix(vec3(.2902,.3961,.6275),vec3(0,.5,1),smoothstep(.02,.022,d));
  // vec3 color=mix(vec3(.3882,.5608,.9333),vec3(0,.5,1),smoothstep(.02,.022,d));
  
  fragColor=vec4(color,1.);
}