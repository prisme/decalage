void mainImage(out vec4 c,in vec2 f)
{
  vec2 r=iResolution.xy,u=((2.*f.xy-r))/r.y;
  vec3 rd=normalize(vec3(u,2.));
  vec3 ro=vec3(0,0,-10);
  
  float ll=0.;
  float cl=50.;
  
  for(int i=0;i<255;i++)
  {
    vec3 p=ro+rd*ll;
    p.xz*=mat2(cos(iTime),-sin(iTime),sin(iTime),cos(iTime));
    vec3 q=abs(p)-vec3(1,2,.001);
    float dd=max(-clamp(sin(iTime+u.y*10.),0.,1.),length(max(q,0.))-min(max(q.x,max(q.y,q.z)),0.));
    
    cl=min(dd,cl);
    
    ll+=dd;
    
    if(abs(dd)<.01||ll>50.)
    break;
  }
  
  vec2 dd=vec2(ll,cl);
  
  // dd.y -= sin(dd.x+ iTime);
  
  float gg=1./(1.+dd.y);
  // gg += abs(cos(iTime + u.y * dd.y)) * 0.1;
  
  vec3 col=vec3(1.,1.,1.)*u.y+vec3(0.,0.,0.)*(1.-u.y);
  
  c=vec4(col*gg,1);
  
  c*=step(.001,dd.x)*sin(iTime+u.y*r.y);
  
}