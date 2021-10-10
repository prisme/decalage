import ShadertoyReact from "shadertoy-react";
import fs from "./glsl/plasma.glsl";

export default function Shader() {
  return (
    <>
      <ShadertoyReact fs={fs} />
    </>
  );
}
