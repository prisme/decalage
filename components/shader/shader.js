import ShadertoyReact from "shadertoy-react";
import darksine from "./glsl/darksine.glsl";

export default function Shader() {
  return (
    <>
      <ShadertoyReact fs={darksine} />
    </>
  );
}
