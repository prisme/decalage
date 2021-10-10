// https://www.shadertoy.com/view/ldBSRd
#define PI 3.14159

vec2 random2(vec2 c){float j=4906.*sin(dot(c,vec2(169.7,5.8)));vec2 r;r.x=fract(512.*j);j*=.125;r.y=fract(512.*j);return r-.5;}

const float F2=.3660254;
const float G2=-.2113249;

float simplex2d(vec2 p){vec2 s=floor(p+(p.x+p.y)*F2),x=p-s-(s.x+s.y)*G2;float e=step(0.,x.x-x.y);vec2 i1=vec2(e,1.-e),x1=x-i1-G2,x2=x-1.-2.*G2;vec3 w,d;w.x=dot(x,x);w.y=dot(x1,x1);w.z=dot(x2,x2);w=max(.5-w,0.);d.x=dot(random2(s+0.),x);d.y=dot(random2(s+i1),x1);d.z=dot(random2(s+1.),x2);w*=w;w*=w;d*=w;return dot(d,vec3(70.));}

vec3 rgb2yiq(vec3 color){return color*mat3(.299,.587,.114,.596,-.274,-.321,.211,-.523,.311);}
vec3 yiq2rgb(vec3 color){return color*mat3(1.,.956,.621,1,-.272,-.647,1.,-1.107,1.705);}

vec3 convertRGB443quant(vec3 color){vec3 out0=mod(color,1./16.);out0.b=mod(color.b,1./8.);return out0;}
vec3 convertRGB443(vec3 color){return color-convertRGB443quant(color);}

vec2 sincos(float x){return vec2(sin(x),cos(x));}
vec2 rotate2d(vec2 uv,float phi){vec2 t=sincos(phi);return vec2(uv.x*t.y-uv.y*t.x,uv.x*t.x+uv.y*t.y);}
vec3 rotate3d(vec3 p,vec3 v,float phi){v=normalize(v);vec2 t=sincos(-phi);float s=t.x,c=t.y,x=-v.x,y=-v.y,z=-v.z;mat4 M=mat4(x*x*(1.-c)+c,x*y*(1.-c)-z*s,x*z*(1.-c)+y*s,0.,y*x*(1.-c)+z*s,y*y*(1.-c)+c,y*z*(1.-c)-x*s,0.,z*x*(1.-c)-y*s,z*y*(1.-c)+x*s,z*z*(1.-c)+c,0.,0.,0.,0.,1.);return(vec4(p,1.)*M).xyz;}

float varazslat(vec2 position,float time){
    float color=0.;
    float t=2.*time;
    color+=sin(position.x*cos(t/10.)*20.)+cos(position.x*cos(t/15.)*10.);
    color+=sin(position.y*sin(t/5.)*15.)+cos(position.x*sin(t/25.)*20.);
    color+=sin(position.x*sin(t/10.)*.2)+sin(position.y*sin(t/35.)*10.);
    color*=sin(t/10.)*.5;
    
    return color;
}

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=fragCoord.xy/iResolution.xy;
    uv=(uv-.5)*2.;
    float time=iTime*.3;
    
    vec3 vlsd=vec3(0,1,0);
    vlsd=rotate3d(vlsd,vec3(1.,1.,0.),time);
    vlsd=rotate3d(vlsd,vec3(1.,1.,0.),time);
    vlsd=rotate3d(vlsd,vec3(1.,1.,0.),time);
    
    vec2
    v0=.75*sincos(.3457*time+.3423)-simplex2d(uv*.917),
    v1=.75*sincos(.7435*time+.4565)-simplex2d(uv*.521),
    v2=.75*sincos(.5345*time+.3434)-simplex2d(uv*.759);
    
    vec3 color=vec3(dot(uv-v0,vlsd.xy),dot(uv-v1,vlsd.yz),dot(uv-v2,vlsd.zx));
    
    color*=.2+2.5*vec3(
        (16.*simplex2d(uv+v0)+8.*simplex2d((uv+v0)*2.)+4.*simplex2d((uv+v0)*4.)+2.*simplex2d((uv+v0)*8.)+simplex2d((v0+uv)*16.))/32.,
        (16.*simplex2d(uv+v1)+8.*simplex2d((uv+v1)*2.)+4.*simplex2d((uv+v1)*4.)+2.*simplex2d((uv+v1)*8.)+simplex2d((v1+uv)*16.))/32.,
        (16.*simplex2d(uv+v2)+8.*simplex2d((uv+v2)*2.)+4.*simplex2d((uv+v2)*4.)+2.*simplex2d((uv+v2)*8.)+simplex2d((v2+uv)*16.))/32.
    );
    
    color=yiq2rgb(color);
    
    color*=1.-.25*vec3(
        varazslat(uv*.25,time+.5),
        varazslat(uv*.7,time+.2),
        varazslat(uv*.4,time+.7)
    );
    
    color=vec3(pow(color.r,.45),pow(color.g,.45),pow(color.b,.45));
    
    fragColor=vec4(color,1.);
}

