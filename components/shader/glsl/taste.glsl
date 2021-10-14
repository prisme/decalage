
// taste of noise by leon denise 2021/10/12
// result of experimentation with organic patterns
// using code from Inigo Quilez
// Licensed under hippie love conspiracy

// rotation matrix
mat2 rot(float a){return mat2(cos(a),-sin(a),sin(a),cos(a));}

// global variable
float material;

// sdf
float map(vec3 p)
{
  // time
  float t=iTime*.1;
  
  // rotation parameter
  vec3 angle=vec3(78.,68.,78.)+t+p;
  
  // kif
  const int count=5;
  float a=1.;
  float scene=1000.;
  float shape=1000.;
  for(int index=0;index<count;++index)
  {
    // fold
    p=abs(p)-.5*a;
    
    // rotate
    p.xz*=rot(angle.y/a);
    p.yz*=rot(angle.x/a);
    p.yx*=rot(angle.z/a);
    
    // sphere
    shape=length(p)-.6*a;
    
    // materialing
    material=shape<scene?float(index):material;
    
    // add
    scene=min(scene,shape);
    
    // falloff
    a/=1.89;
  }
  
  // shell
  scene=abs(scene);
  
  // surface details
  float d=length(p);
  float details=abs(sin(d*20.))*.05;
  scene-=details;
  
  return scene;
}

// return color from pixel coordinate
void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
  // reset color
  fragColor=vec4(0);
  material=0.;
  
  // camera coordinates
  vec2 uv=(fragCoord.xy-iResolution.xy*.5)/iResolution.y;
  vec3 eye=vec3(0,0,-1);
  vec2 mouse=iMouse.xy/iResolution.xy;
  eye.xz*=rot(.4+mouse.x);
  eye.xy*=rot(.6-mouse.y);
  vec3 z=normalize(-eye);
  vec3 x=normalize(cross(z,vec3(0,1,0)));
  vec3 y=normalize(cross(x,z));
  vec3 ray=normalize(vec3(z*.5+uv.x*x+uv.y*y));
  vec3 pos=eye+ray*.5;
  
  // raymarch
  const int steps=20;
  for(int index=steps;index>0;--index)
  {
    // volume estimation
    float dist=map(pos);
    if(dist<.01)
    {
      // Inigo Quilez color palette (https://iquilezles.org/www/articles/palettes/palettes.htm)
      vec3 tint=vec3(.2)+vec3(.8)*cos(vec3(1,2,3)*material*.2-length(pos)*2.);
      
      // pixel color
      float shade=float(index)/float(steps);
      fragColor.rgb=tint*shade;
      
      break;
    }
    
    // raymarch
    pos+=ray*dist;
  }
}

